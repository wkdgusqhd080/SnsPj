package sns.test.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import sns.vo.A;

public interface TestMapper {
	List<A> selectTest();
	List<A> selectTest2();
}
