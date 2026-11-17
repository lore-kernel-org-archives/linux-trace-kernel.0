Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942132;
	b=ttkIguCsJGqCagA5Tu+XdGCpCh6xk7l7JrxvV5PkKNg+c5cIT5LRUk3EQ8EkZPOpc7Ab
	 w+1emcF9OW0Tpo1B3wybTymepFQRYKvYll/Bs9wAwbDayyviWlEAGDzyeWRnnhvlBb1CI
	 33Fw9r/EAHhTEpJQ6Pnc8EpT+pZ26YBLvIldU0If1rFTrvInbl74MVj8pxAmQqTiPELhX
	 oEfcLawv2UnHVyppQabEAAJ7+c6n+Uj0QUSAZ6APp13b5RvX+lwDZm6nICwsyVDz05a41
	 uuwQLW+00Ok80vjHTG5Nfveq2H34JKR1Yd5yKbmCRyBO3VlAcJ7cvcO33uw0S9sJhUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942132;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=OpHP5+r7PMgqmmP8JUJj187R7NU47kw8/jMVCHkZJ3U=;
	b=jio4bBMx925raF0FsvVQfWxr5VSP3AQkjaAaftFfzkZCuz3LwngnbJTHL3qeNoxD62kO
	 Cv89d/XcU1X3TLtd3zj9bO4FfUmGZ/AJJ2fvbvXmMHWyGAidvYFzW3GvVk87rX/bT57sa
	 fWe16wwW0YSZourz+Arl2h6oOk1X5pTF6ZqI2tZ+8aMFWu/vuMMX6ulG5Pc9Bdx0VumcH
	 H2N4MUt+1GJIwvSeWQaVTLri327Ch3gFMyvk+UaXQu7Ns+UantNhADsZqsKdwSargwZTh
	 mU1gRjROKzj+DQ7ao0e5WkWn5hloHn7leZ5BRqGb3LTM5wg3tgrB6VmeQqU0JaYhczQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=CCoksJk7;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE93E606A31C;
	Tue, 17 Nov 2026 19:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE93E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=CCoksJk7
Received: from CPC-beaub-VBQ1L.localdomain (unknown [70.37.26.63])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5F51620B7169;
	Tue, 17 Nov 2026 11:02:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5F51620B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794942130;
	bh=OpHP5+r7PMgqmmP8JUJj187R7NU47kw8/jMVCHkZJ3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CCoksJk7Juzoqc8yO9WPlxV6y/S35BixMSewmHyV0sxZPiOM6ML/JnOj5CGBEAJQp
	 2fjwzGVVQ7hBTOcAewrYayz+XuOfxBbu3tXcmgjU2oAXqbdLkwpN1+uzuEcrU8TyzI
	 xfuWS1FeLPGIX3p2gkFxMSoHhzuTPIKV1GfAM0DU=
Date: Tue, 17 Nov 2026 19:02:03 +0000
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Danish Khateeb <danishkhateeb03@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>, linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/user_events: Fix pointer casts for 32-bit
 builds
Message-ID: <20261117190203.GA590-beaub@linux.microsoft.com>
References: <20260928171424.199202-1-danishkhateeb03@gmail.com>
 <20260928171424.199202-2-danishkhateeb03@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928171424.199202-2-danishkhateeb03@gmail.com>

On Mon, Sep 28, 2026 at 12:14:24PM -0500, Danish Khateeb wrote:
> The tests cast pointers directly to __u64. On 32-bit builds GCC
> sign-extends such casts, so addresses above 2 GiB, like the stack of a
> 32-bit task on a 64-bit kernel, become 0xffffffffxxxxxxxx and every
> registration fails.
> 
> Cast through uintptr_t so the tests also work when built for 32-bit and
> cover the compat ioctl path.
> 
> Assisted-by: LLM
> Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
> ---
> 
> Notes:
>     Built with and without -m32. With 1/2 applied, the 32-bit tests pass on
>     x86_64; the 64-bit binaries are unchanged in behaviour and still pass.
>     The -Wpointer-to-int-cast warnings left in a 32-bit build come from
>     kselftest_harness.h, not from these tests.
> 
>  .../testing/selftests/user_events/abi_test.c  | 10 +++---
>  .../testing/selftests/user_events/dyn_test.c  |  6 ++--
>  .../selftests/user_events/ftrace_test.c       | 32 +++++++++----------
>  .../testing/selftests/user_events/perf_test.c | 10 +++---
>  4 files changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
> index b71813eaf5c0..21e1e3cca197 100644
> --- a/tools/testing/selftests/user_events/abi_test.c
> +++ b/tools/testing/selftests/user_events/abi_test.c
> @@ -179,10 +179,10 @@ static int reg_enable_multi(void *enable, int size, int bit, int flags,
>  	}
>  
>  	reg.size = sizeof(reg);
> -	reg.name_args = (__u64)full_args;
> +	reg.name_args = (__u64)(uintptr_t)full_args;
>  	reg.flags = USER_EVENT_REG_MULTI_FORMAT | flags;
>  	reg.enable_bit = bit;
> -	reg.enable_addr = (__u64)enable;
> +	reg.enable_addr = (__u64)(uintptr_t)enable;
>  	reg.enable_size = size;
>  
>  	ret = ioctl(fd, DIAG_IOCSREG, &reg);
> @@ -202,10 +202,10 @@ static int reg_enable_flags(void *enable, int size, int bit, int flags)
>  		return -1;
>  
>  	reg.size = sizeof(reg);
> -	reg.name_args = (__u64)"__abi_event";
> +	reg.name_args = (__u64)(uintptr_t)"__abi_event";
>  	reg.flags = flags;
>  	reg.enable_bit = bit;
> -	reg.enable_addr = (__u64)enable;
> +	reg.enable_addr = (__u64)(uintptr_t)enable;
>  	reg.enable_size = size;
>  
>  	ret = ioctl(fd, DIAG_IOCSREG, &reg);
> @@ -231,7 +231,7 @@ static int reg_disable(void *enable, int bit)
>  
>  	reg.size = sizeof(reg);
>  	reg.disable_bit = bit;
> -	reg.disable_addr = (__u64)enable;
> +	reg.disable_addr = (__u64)(uintptr_t)enable;
>  
>  	ret = ioctl(fd, DIAG_IOCSUNREG, &reg);
>  
> diff --git a/tools/testing/selftests/user_events/dyn_test.c b/tools/testing/selftests/user_events/dyn_test.c
> index 78e3c33f4015..32f159544d0b 100644
> --- a/tools/testing/selftests/user_events/dyn_test.c
> +++ b/tools/testing/selftests/user_events/dyn_test.c
> @@ -58,9 +58,9 @@ static int reg_event(int fd, int *check, int bit, const char *value)
>  	struct user_reg reg = {0};
>  
>  	reg.size = sizeof(reg);
> -	reg.name_args = (__u64)value;
> +	reg.name_args = (__u64)(uintptr_t)value;
>  	reg.enable_bit = bit;
> -	reg.enable_addr = (__u64)check;
> +	reg.enable_addr = (__u64)(uintptr_t)check;
>  	reg.enable_size = sizeof(*check);
>  
>  	if (ioctl(fd, DIAG_IOCSREG, &reg) == -1)
> @@ -75,7 +75,7 @@ static int unreg_event(int fd, int *check, int bit)
>  
>  	unreg.size = sizeof(unreg);
>  	unreg.disable_bit = bit;
> -	unreg.disable_addr = (__u64)check;
> +	unreg.disable_addr = (__u64)(uintptr_t)check;
>  
>  	return ioctl(fd, DIAG_IOCSUNREG, &unreg);
>  }
> diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
> index decce06b9ba8..b9c75202f0bd 100644
> --- a/tools/testing/selftests/user_events/ftrace_test.c
> +++ b/tools/testing/selftests/user_events/ftrace_test.c
> @@ -127,7 +127,7 @@ static int clear(int *check)
>  
>  	unreg.size = sizeof(unreg);
>  	unreg.disable_bit = 31;
> -	unreg.disable_addr = (__u64)check;
> +	unreg.disable_addr = (__u64)(uintptr_t)check;
>  
>  	fd = open(data_file, O_RDWR);
>  
> @@ -174,9 +174,9 @@ static int check_print_fmt(const char *event, const char *expected, int *check)
>  		return fd;
>  
>  	reg.size = sizeof(reg);
> -	reg.name_args = (__u64)event;
> +	reg.name_args = (__u64)(uintptr_t)event;
>  	reg.enable_bit = 31;
> -	reg.enable_addr = (__u64)check;
> +	reg.enable_addr = (__u64)(uintptr_t)check;
>  	reg.enable_size = sizeof(*check);
>  
>  	/* Register should work */
> @@ -239,14 +239,14 @@ TEST_F(user, register_events) {
>  	struct user_unreg unreg = {0};
>  
>  	reg.size = sizeof(reg);
> -	reg.name_args = (__u64)"__test_event u32 field1; u32 field2";
> +	reg.name_args = (__u64)(uintptr_t)"__test_event u32 field1; u32 field2";
>  	reg.enable_bit = 31;
> -	reg.enable_addr = (__u64)&self->check;
> +	reg.enable_addr = (__u64)(uintptr_t)&self->check;
>  	reg.enable_size = sizeof(self->check);
>  
>  	unreg.size = sizeof(unreg);
>  	unreg.disable_bit = 31;
> -	unreg.disable_addr = (__u64)&self->check;
> +	unreg.disable_addr = (__u64)(uintptr_t)&self->check;
>  
>  	/* Register should work */
>  	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
> @@ -263,13 +263,13 @@ TEST_F(user, register_events) {
>  
>  	/* Register without separator spacing should still match */
>  	reg.enable_bit = 29;
> -	reg.name_args = (__u64)"__test_event u32 field1;u32 field2";
> +	reg.name_args = (__u64)(uintptr_t)"__test_event u32 field1;u32 field2";
>  	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
>  	ASSERT_EQ(0, reg.write_index);
>  
>  	/* Multiple registers to same name but different args should fail */
>  	reg.enable_bit = 29;
> -	reg.name_args = (__u64)"__test_event u32 field1;";
> +	reg.name_args = (__u64)(uintptr_t)"__test_event u32 field1;";
>  	ASSERT_EQ(-1, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
>  	ASSERT_EQ(EADDRINUSE, errno);
>  
> @@ -310,9 +310,9 @@ TEST_F(user, write_events) {
>  	int before = 0, after = 0;
>  
>  	reg.size = sizeof(reg);
> -	reg.name_args = (__u64)"__test_event u32 field1; u32 field2";
> +	reg.name_args = (__u64)(uintptr_t)"__test_event u32 field1; u32 field2";
>  	reg.enable_bit = 31;
> -	reg.enable_addr = (__u64)&self->check;
> +	reg.enable_addr = (__u64)(uintptr_t)&self->check;
>  	reg.enable_size = sizeof(self->check);
>  
>  	field1 = 1;
> @@ -367,9 +367,9 @@ TEST_F(user, write_empty_events) {
>  	int before = 0, after = 0;
>  
>  	reg.size = sizeof(reg);
> -	reg.name_args = (__u64)"__test_event";
> +	reg.name_args = (__u64)(uintptr_t)"__test_event";
>  	reg.enable_bit = 31;
> -	reg.enable_addr = (__u64)&self->check;
> +	reg.enable_addr = (__u64)(uintptr_t)&self->check;
>  	reg.enable_size = sizeof(self->check);
>  
>  	io[0].iov_base = &reg.write_index;
> @@ -401,9 +401,9 @@ TEST_F(user, write_fault) {
>  	void *anon;
>  
>  	reg.size = sizeof(reg);
> -	reg.name_args = (__u64)"__test_event u64 anon";
> +	reg.name_args = (__u64)(uintptr_t)"__test_event u64 anon";
>  	reg.enable_bit = 31;
> -	reg.enable_addr = (__u64)&self->check;
> +	reg.enable_addr = (__u64)(uintptr_t)&self->check;
>  	reg.enable_size = sizeof(self->check);
>  
>  	anon = mmap(NULL, l, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> @@ -439,9 +439,9 @@ TEST_F(user, write_validator) {
>  	int before = 0, after = 0;
>  
>  	reg.size = sizeof(reg);
> -	reg.name_args = (__u64)"__test_event __rel_loc char[] data";
> +	reg.name_args = (__u64)(uintptr_t)"__test_event __rel_loc char[] data";
>  	reg.enable_bit = 31;
> -	reg.enable_addr = (__u64)&self->check;
> +	reg.enable_addr = (__u64)(uintptr_t)&self->check;
>  	reg.enable_size = sizeof(self->check);
>  
>  	/* Register should work */
> diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
> index 5727cb5b914c..b444d114b2f0 100644
> --- a/tools/testing/selftests/user_events/perf_test.c
> +++ b/tools/testing/selftests/user_events/perf_test.c
> @@ -89,7 +89,7 @@ static int clear(int *check)
>  
>  	unreg.size = sizeof(unreg);
>  	unreg.disable_bit = 31;
> -	unreg.disable_addr = (__u64)check;
> +	unreg.disable_addr = (__u64)(uintptr_t)check;
>  
>  	int fd = open(data_file, O_RDWR);
>  
> @@ -160,9 +160,9 @@ TEST_F(user, perf_write) {
>  	__u32 *val;
>  
>  	reg.size = sizeof(reg);
> -	reg.name_args = (__u64)"__test_event u32 field1; u32 field2";
> +	reg.name_args = (__u64)(uintptr_t)"__test_event u32 field1; u32 field2";
>  	reg.enable_bit = 31;
> -	reg.enable_addr = (__u64)&self->check;
> +	reg.enable_addr = (__u64)(uintptr_t)&self->check;
>  	reg.enable_size = sizeof(self->check);
>  
>  	/* Register should work */
> @@ -224,9 +224,9 @@ TEST_F(user, perf_empty_events) {
>  	__u32 *val;
>  
>  	reg.size = sizeof(reg);
> -	reg.name_args = (__u64)"__test_event";
> +	reg.name_args = (__u64)(uintptr_t)"__test_event";
>  	reg.enable_bit = 31;
> -	reg.enable_addr = (__u64)&self->check;
> +	reg.enable_addr = (__u64)(uintptr_t)&self->check;
>  	reg.enable_size = sizeof(self->check);
>  
>  	/* Register should work */
> -- 
> 2.55.0
> 

Thanks!

Acked-by: Beau Belgrave <beaub@linux.microsoft.com>

-Beau
