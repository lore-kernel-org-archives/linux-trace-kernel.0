Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F46E1990C1;
	Thu,  6 Feb 2025 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738870992; cv=none; b=P86iicwnkqrtg6BUeZLbr79gQ3tdmWhPEWdMT7/rNLSfMiExRDVdXmcTUffA43FNL3BV67jtonwpbG6gWez7k+rP31DnOdrP3KGAKUvTx/3Tt4/AhYt1NUKdJI3F7Io1UDK1fCPxwAcWtUfMhaPyTPgkx8Mob6XSGWRAljr8mqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738870992; c=relaxed/simple;
	bh=JVngml0+5obmLEOoHc7/+pi3gcZa6bg05TXxb5hLsag=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=kNN7YVyNWvagK1FtHy3HHQy2i+o9P3OfV/PCLsYhECgKSbyC+0Q8l8DgcUVaMfXaRn1VnoRveJySar1IgUEdfoVE9DeowmdcsWfU+NsQat9Um6+u1061yatZwzUfXbIC2Suse9/DfKKwkGVyopD1HdzDyNqHQHIBu+bZpcOGJ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=MZMrmUBv; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="MZMrmUBv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1738870982;
	bh=hb/VRdBvoOPQUGQgI2/03oKonh4Fn4N6DJ1GnbGVOIA=;
	h=From:To:Cc:Subject:Date;
	b=MZMrmUBv9qOoVU8TYOPWUd7asdtLSD0Q2xTGbCOid16IbbOUJ+9CxqOXoGhPBcMZe
	 0qjYef+t+7pGRnjjxT6f/mQLj0pZp1Qt/KA5nbXuEgvGMs5/uICWk8Elc6hjAO7v/c
	 gY3gVPbQ+EVf0R/H68Yh1090OzQ8PtU2dcac6c6w=
Received: from debian.localdomain ([130.126.255.141])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 76C89252; Fri, 07 Feb 2025 03:29:44 +0800
X-QQ-mid: xmsmtpt1738870184tmphv9uhz
Message-ID: <tencent_AE90AA59903A628E87E9F80E563DA5BA5508@qq.com>
X-QQ-XMAILINFO: ONXjbYTFhCz05A1HOGH3Uq7V0ThlxAWGNw21QxOoVGfe3lNjILDMymu4O3Pxay
	 GlNyDXNldkP6Vlbtjb5/g1qwOKoikYknDU6Nh3m2gU7k+5sjIDH1axEFip04jmVp2l8ysSPzIqLW
	 uqPGJqvjK4uCtfOiKDkye5m4cgw3xGUVMbY6LYmuVjYY/lWCULTP0/B9CL6gZXjJV6lCX1EwJdM/
	 oTc8W7pSONXg/OF9VacGckJoEDGj6Bm0uEMxVSxUewQeUnvwgsV0gTFeUybNXEsteCPeJEp4KjSb
	 MUzg84lqCPyOSpeH6JKKo8inKo40BKP526GJbzdtg4AyzVqM33U0Rlq8YS1PXraavRDkWQ+m7LZ8
	 ZGFdO8RuD6DHLDOmOeNzxEQNFwnMePzTtputDcWmH9f6kGWBUwNDOhTcvxENa59xTuIv7fskAwUX
	 zbBGZFjdFbvLOXBHkXrPIsuqxVD1O0FLFUbSwPjUw9lduEKvtHGJ4g0IVSylKk43o7QbMyrP1VfC
	 k4aUdBz6iVloQVfkIpihxmSdxFtzFyeRZ1nAsr7nLeYV+hq5IaPqTYtRID5ftk0kpg3g3jQLOyfK
	 X24g82kvJKMeGY31FKnoFEdyoydj3aoO1c0tiMbQ8MRQPY2a2WfEx9gjeix8stGPyXUW2jYMC4Bk
	 nqmxP9oJtZBcPFlUwodsT7m2K6quPdRbQyjEADTy9An6+rpN1+4ncpP6+pM3iVcDUmsrvpRouMfZ
	 VJKkCEdXm0/DCeqHIUS2+EgUPLj+wSeyhjk2IbqXjLLfhmswNiQOdp8LhhV0Q+AWLRuRww/NiN6v
	 enO2WYUqZSX+Mazr9vz6JBU+e6RWfFt78WY85hlHDEl4D3y558Bs5bvIgRLyH1H0D249HA1vqmJ9
	 Jg7qAP/oTEmGqpxcqsBnTqvAKhQltKgCv4FS3Orwgls1bfcXs9XnHSOUA35khQVwR6+KtHRQHYLu
	 StqkHzyhIhyXgc/0K0OHomrC5TBT2/
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Juhan Jin <juhan.jin@foxmail.com>
To: guoren@kernel.org,
	guoren@linux.alibaba.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Juhan Jin <juhan.jin@foxmail.com>
Subject: [PATCH] riscv: ftrace: Add parentheses in macro definitions of make_call_t0 and make_call_ra
Date: Thu,  6 Feb 2025 13:28:36 -0600
X-OQ-MSGID: <20250206192836.208698-1-juhan.jin@foxmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds parentheses to parameters caller and callee of macros
make_call_t0 and make_call_ra. Every existing invocation of these two
macros uses a single variable for each argument, so the absence of the
parentheses seems okay. However, future invocations might use more
complex expressions as arguments. For example, a future invocation might
look like this: make_call_t0(a - b, c, call). Without parentheses in the
macro definition, the macro invocation expands to:

...
unsigned int offset = (unsigned long) c - (unsigned long) a - b;
...

which is clearly wrong.

The use of parentheses ensures arguments are correctly evaluated and
potentially saves future users of make_call_t0 and make_call_ra debugging
trouble.

Fixes: 6724a76cff85 ("riscv: ftrace: Reduce the detour code size to half")
Signed-off-by: Juhan Jin <juhan.jin@foxmail.com>
---
 arch/riscv/include/asm/ftrace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index c4721ce44ca4..2636ee00ccf0 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -92,7 +92,7 @@ struct dyn_arch_ftrace {
 #define make_call_t0(caller, callee, call)				\
 do {									\
 	unsigned int offset =						\
-		(unsigned long) callee - (unsigned long) caller;	\
+		(unsigned long) (callee) - (unsigned long) (caller);	\
 	call[0] = to_auipc_t0(offset);					\
 	call[1] = to_jalr_t0(offset);					\
 } while (0)
@@ -108,7 +108,7 @@ do {									\
 #define make_call_ra(caller, callee, call)				\
 do {									\
 	unsigned int offset =						\
-		(unsigned long) callee - (unsigned long) caller;	\
+		(unsigned long) (callee) - (unsigned long) (caller);	\
 	call[0] = to_auipc_ra(offset);					\
 	call[1] = to_jalr_ra(offset);					\
 } while (0)

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.39.5

