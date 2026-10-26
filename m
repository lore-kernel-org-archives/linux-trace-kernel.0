Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793046404;
	b=t+5nIfbAACQHRLPErX3jh6dUFwp15q4NdbzIybBU8gQLLsXw1SKurRH2eYLYJNHQInPf
	 P2xvOF/E4uUxr2TPpoBVtGAKOTf5jc2RfPsqa3nI5f/rSKPiGoIaFCO+dObsZsUbghBs+
	 shEVR0WNkBOPGc1xijxJvPwdRyk4HcsNtaMCEB5vOvG+rbg/lai/r4mAtgaoR46Rcjzte
	 FZFjlc9r42Z10sQpHxPR1QShYtELcXngsTZxYrDSWcWxMNOQlPgDFAev6NDsefY2F1b5k
	 CyqRKX4LvwXJ4sU2fxmRiT8pdHIcqLp+Pe8uBkYWTntQZ/IHo2v4R+8DL/9Xk+KKYVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046404;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=auFyGna21fuhlKrwP/c9SqV5FpuguPtg50Z4lkhoeRw=;
	b=Lky1E1q2r+W+TIuZNJLnki1tiF1jCp2Ka6OcIki94c4KB6dkiyu+asT07+jzXjPRj014
	 2enyC+yNwZvq6Goi7y6rA9oi9o9a5XqqQqGf0uPevJHVU+tdYSskW8FJz6r7pUPUQFHvy
	 JmYAvV3T/cTcwCqDEAI57pfBQp8oiaeKTMcVylxSYp9PMOZICZQrgOzlZ5WyZpOyRwvwY
	 36FKuqBfkS0dh3qV3kjs0Agvv7Dih/508Juu25Hx1AcX/BDBwJjuvZ3yBY2lXMNXRkQIo
	 maes/6uSjpR7o5pG+asc3osbn8E6SCbZErQmKwS3KDLNGp3hzor+ScgOJQ3cOo0Vgrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RAJ1NI1c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16EA606A31D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RAJ1NI1c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3EA1F01825;
	Mon, 26 Oct 2026 20:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793046403;
	bh=auFyGna21fuhlKrwP/c9SqV5FpuguPtg50Z4lkhoeRw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RAJ1NI1cFPfvIooCgX8OhdavnSvM0lx7IScicbVZ5prAzKPfFXBIG/ry/LIajTwSl
	 zRHWXe5Ij5Q09/VQkcdJkv4/WPR9nne3y3sv2ahxRLVVueOPB4LjFLt6mznr0Jpws5
	 aHVvNPJvrbWkOvBCjMJvtxDS1eR11Ty/WZd6feRQVeMfL1j91YN6sJC3Ai6YhrvpgD
	 TdNIPBe9UmVeUEvde/sVLbveK036t8CxbvaNtTKd7VxfmESPXZLFVClmDDsFh3qj1y
	 HgHp6jd/BG6iDSjyhqc49XyCa6AXsYRoDZ2VvQiJ4sb84sXAaoRiXzN7uS3CwoAJR7
	 Rdd8ZZ8jy3EHw==
Message-ID: <sashiko-outbox-185716@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] openrisc: Add unit tests for KProbes on branch
 instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sahil Siddiq" <sahilcdq0@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261026201240.107462-4-sahilcdq0@gmail.com>
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
 <20261026201240.107462-4-sahilcdq0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 20:26:42 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] openrisc: kprobes test probes l.addi instead of forward l.j in t=
est_kprobes_j()
- [Medium] openrisc: kprobes test leaves r13 stale, misplaces label, and la=
cks fallthrough returns
--

commit d7000f832374f65f339afc3c16fe2e9e5cfe971f
Author: Sahil Siddiq <sahilcdq0@gmail.com>

openrisc: Add unit tests for KProbes on branch instructions

This commit adds KUnit tests for OpenRISC KProbes to verify instruction
simulation and delay slot handling for branch, jump, and page-relative
address calculation instructions.

> diff --git a/arch/openrisc/kernel/tests/test_kprobes_asm.S b/arch/openris=
c/kernel/tests/test_kprobes_asm.S
> new file mode 100644
> index 0000000000000..bc87a5fb00d52
> --- /dev/null
> +++ b/arch/openrisc/kernel/tests/test_kprobes_asm.S
> @@ -0,0 +1,157 @@

[ ... ]

> +SYM_FUNC_START(test_kprobes_j)
> +test_kprobes_j_addr1:
> +	l.addi	r11,r0,0
> +	l.j	2f
> +	l.nop

[Severity: Medium]
Should test_kprobes_j_addr1 be placed after l.addi r11,r0,0 and immediately
before l.j 2f?

When test_kprobe_openrisc() in arch/openrisc/kernel/tests/test_kprobes.c
iterates over test_kprobes_addresses[] and calls register_kprobe(),
test_kprobes_j_addr1 currently points to l.addi r11,r0,0 instead of the
forward jump instruction l.j 2f. As a result, the kprobe is installed on
l.addi rather than testing branch simulation on the forward l.j instruction.

> +1:	l.ori	r13,r13,KPROBE_TEST_MAGIC_LOWER
> +	l.addi	r11,r13,0
> +	l.jr	r9
> +	l.nop
> +2:	l.movhi	r13,KPROBE_TEST_MAGIC_UPPER
> +test_kprobes_j_addr2:
> +	l.j	1b
> +	l.nop
> +SYM_FUNC_END(test_kprobes_j)
> +
> +SYM_FUNC_START(test_kprobes_jal)
> +	l.addi	r11,r0,0
> +	l.addi	r15,r9,0
> +test_kprobes_jal_addr1:
> +	l.jal	2f
> +	l.nop
> +1:	l.movhi	r13,KPROBE_TEST_MAGIC_UPPER
> +	l.jr	r9
> +	l.nop
> +test_kprobes_jal_addr2:
> +2:	l.jal	1b
> +	l.nop
> +	l.ori	r13,r13,KPROBE_TEST_MAGIC_LOWER
> +	l.addi	r11,r13,0
> +	l.addi	r9,r15,0
> +	l.jr	r9
> +	l.nop
> +SYM_FUNC_END(test_kprobes_jal)
> +
> +SYM_FUNC_START(test_kprobes_jr)
> +	l.addi	r11,r0,0
> +	l.movhi	r15,hi(2f)
> +	l.ori	r15,r15,lo(2f)
> +test_kprobes_jr_addr1:
> +	l.jr	r15
> +	l.nop
> +1:	l.ori	r13,r13,KPROBE_TEST_MAGIC_LOWER
> +	l.addi	r11,r13,0
> +	l.jr	r9
> +	l.nop
> +2:	l.movhi	r13,KPROBE_TEST_MAGIC_UPPER
> +	l.movhi	r15,hi(1b)
> +	l.ori	r15,r15,lo(1b)
> +test_kprobes_jr_addr2:
> +	l.jr	r15
> +	l.nop
> +SYM_FUNC_END(test_kprobes_jr)
> +
> +SYM_FUNC_START(test_kprobes_jalr)
> +	l.addi	r11,r0,0
> +	l.addi	r15,r9,0
> +	l.movhi	r17,hi(2f)
> +	l.ori	r17,r17,lo(2f)
> +test_kprobes_jalr_addr1:
> +	l.jalr	r17
> +	l.nop
> +1:	l.movhi	r13,KPROBE_TEST_MAGIC_UPPER
> +	l.jr	r9
> +	l.nop
> +2:	l.movhi	r17,hi(1b)
> +	l.ori	r17,r17,lo(1b)
> +test_kprobes_jalr_addr2:
> +	l.jalr	r17
> +	l.nop
> +	l.ori	r13,r13,KPROBE_TEST_MAGIC_LOWER
> +	l.addi	r11,r13,0
> +	l.addi	r9,r15,0
> +	l.jr	r9
> +	l.nop
> +SYM_FUNC_END(test_kprobes_jalr)
> +
> +SYM_FUNC_START(test_kprobes_branch)
> +	l.addi	r11,r0,0
> +	l.addi	r15,r0,1
> +	l.addi	r17,r0,0
> +	l.sfgts	r15,r17
> +test_kprobes_branch_addr1:
> +	l.bf	2f
> +	l.nop
> +1:	l.ori	r13,r13,KPROBE_TEST_MAGIC_LOWER
> +	l.addi	r11,r13,0
> +	l.jr	r9
> +	l.nop
> +2:	l.movhi	r13,KPROBE_TEST_MAGIC_UPPER
> +	l.sfeq	r15,r17
> +test_kprobes_branch_addr2:
> +	l.bnf	1b
> +	l.nop
> +SYM_FUNC_END(test_kprobes_branch)

[Severity: Medium]
Can stale values in r13 and missing fallthrough returns in test_kprobes_j(),
test_kprobes_jal(), test_kprobes_jr(), test_kprobes_jalr(), and
test_kprobes_branch() cause false passes or execution past function
boundaries if branch simulation fails?

First, each of these functions initializes r11 to 0 at entry:

    l.addi  r11,r0,0

However, they construct KPROBE_TEST_MAGIC in r13 using l.movhi and l.ori, a=
nd
then copy r13 into r11 before returning:

    l.ori   r13,r13,KPROBE_TEST_MAGIC_LOWER
    l.addi  r11,r13,0

Unlike test_kprobes_adrp(), these five functions do not clear r13 on entry.
Because the preceding test function in test_kprobe_openrisc() leaves
0xDEADC0DE in r13, if a simulated branch (such as l.jal 1b at
test_kprobes_jal_addr2, l.jr r15 at test_kprobes_jr_addr1, l.jalr r17 at
test_kprobes_jalr_addr2, or l.bf 2f at test_kprobes_branch_addr1) fails to
branch and falls through to label 1 (or the instructions following the call=
),
l.ori r13,r13,KPROBE_TEST_MAGIC_LOWER preserves the upper bits of r13 from
the previous test, overwrites r11 with 0xDEADC0DE, and returns a false
success.

Second, in test_kprobes_j(), test_kprobes_jr(), and test_kprobes_branch(),
there is no return sequence (l.jr r9; l.nop) after the backward branch at
test_kprobes_j_addr2, test_kprobes_jr_addr2, and test_kprobes_branch_addr2.
If one of those backward branches is not taken, execution will fall off the
end of the function into the next function in .text (or, after
test_kprobes_branch(), into the .align PAGE_SIZE zero-padding where
0x00000000 encodes l.j 0, an infinite self-jump) instead of returning to
test_kprobe_openrisc() with a failure value in r11.

Would it make sense to clear r13 on entry in all test functions and add a
fallthrough return after the backward branches?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026201240.1074=
62-1-sahilcdq0@gmail.com?part=3D3
