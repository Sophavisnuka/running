import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/data/models/place_result.dart';
import 'package:running_app/presentation/view_model/location_vm.dart';

class SearchBarWidget extends StatefulWidget {
  final ValueChanged<PlaceResult> onPlaceSelected;

  const SearchBarWidget({
    super.key,
    required this.onPlaceSelected,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _isSearching = false;

  Future<void> _handleSearch(String query) async {
    if (query.trim().isEmpty) return;

    setState(() => _isSearching = true);

    final locationVm = context.read<LocationViewModel>();
    final results = await locationVm.searchPlaces(query);

    if (!mounted) return;
    setState(() => _isSearching = false);

    if (results.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No matching places found')),
      );
      return;
    }

    _showResults(results);
  }

  void _showResults(List<PlaceResult> results) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: results.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final place = results[index];
              return ListTile(
                leading: const Icon(Icons.place_outlined),
                title: Text(
                  place.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  // Talk to the ViewModel directly — no callback needed.
                  context.read<LocationViewModel>().placeSelected(place);
                },
              );
            },
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Search a place to run',
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade500,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey.shade500,
            size: 22,
          ),
          suffixIcon: _isSearching
            ? const Padding(
                padding: EdgeInsets.all(10),
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            : null,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onSubmitted: _handleSearch,
      ),
    );
  }
}