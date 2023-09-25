package xyz.dreams.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import xyz.dreams.dto.CartVO;
import xyz.dreams.dto.OrderDTO;

@Repository
public interface OrderDAO {
	int insert(OrderDTO payment);

	List<OrderDTO> myOrderList(String memberId);

	List<OrderDTO> allOrderList();

	OrderDTO selectByOrderId(String impUid);

	boolean updateOrderStatus(OrderDTO orderDTO);

	int orderCancel(OrderDTO orderDTO);

	int getAmount();

	OrderDTO selectOrderId(String impUid, String memberId);
}
