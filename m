Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2653BA41;
	Tue, 28 May 2024 02:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716862134; cv=none; b=I1rSaa6sGWSILht7gU0EG52dFSN7ps3qL9wVXmb1TJRnqPLRZjTDV0C5j/1fTnN1PE5uKWGrgWYAA3p0C+l8VN16eEPRppwzWdPXUCJEBbT82uNWFeYg+kbIktHFxwRLmRLXxQqQ+IoCUyt5K9c3M4ZSNh9X/YWluG2+qbGwTqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716862134; c=relaxed/simple;
	bh=EHKgLQvEv0vj2n0cflzk9NvLm8L9vB++ui8RqfgTcWc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gFDrXNdqRhg3OcMGwA2x64pmIGqbQz6rUQ92NdDIdPPauVqDD+3OIljnlPLHZDyAdE1y/oTxwaTg9N7Drm8zeCixm2CwE3Ia7DXJw9ssApOiVBVTPYa0LpBF1ZwWZvOczRewVBy2xlYkMXrSdTaLJ1D2o/jyT8ZjnekHNeSvqu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvuprJdQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvuprJdQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDF7C2BBFC;
	Tue, 28 May 2024 02:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716862134;
	bh=EHKgLQvEv0vj2n0cflzk9NvLm8L9vB++ui8RqfgTcWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WvuprJdQYxXystfbtkrqTfz1NZjWqOPaACFUqwBgoWbxe8yzQxizSzSshAnmh8sSY
	 AJRzc98LQjnKyFGlWTdk17LkQL7lCF78d6941BxxrkAnBXbB5dw0VqCbR4FWcpHcII
	 e1ZpL3073tOUrnyzH+0KBHhUsZkwWhOm66XOhqglvMCybMv8tbhtpr9OlfeUXhYU6c
	 XgKUgeUsLIuizEVqF0qlK0orrsDs0ALbQ9q/u30/cjCzQyxRKRfRnB1E1yaiQjnDHm
	 +CQmSyRL4r6coIzjkVAbthMWS25pE3UWa2l8BRRexSaRfvJI5BYLRGdLkh85g8dZzx
	 NWB5Qp/6GAmfg==
Date: Tue, 28 May 2024 11:08:50 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 dcook@linux.microsoft.com
Subject: Re: [PATCH v2 2/2] selftests/user_events: Add non-spacing separator
 check
Message-Id: <20240528110850.47962854c754f420d1db4685@kernel.org>
In-Reply-To: <20240423162338.292-3-beaub@linux.microsoft.com>
References: <20240423162338.292-1-beaub@linux.microsoft.com>
	<20240423162338.292-3-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Apr 2024 16:23:38 +0000
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> The ABI documentation indicates that field separators do not need a
> space between them, only a ';'. When no spacing is used, the register
> must work. Any subsequent register, with or without spaces, must match
> and not return -EADDRINUSE.
> 
> Add a non-spacing separator case to our self-test register case to ensure
> it works going forward.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> ---
>  tools/testing/selftests/user_events/ftrace_test.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
> index dcd7509fe2e0..0bb46793dcd4 100644
> --- a/tools/testing/selftests/user_events/ftrace_test.c
> +++ b/tools/testing/selftests/user_events/ftrace_test.c
> @@ -261,6 +261,12 @@ TEST_F(user, register_events) {
>  	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
>  	ASSERT_EQ(0, reg.write_index);
>  
> +	/* Register without separator spacing should still match */
> +	reg.enable_bit = 29;
> +	reg.name_args = (__u64)"__test_event u32 field1;u32 field2";
> +	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
> +	ASSERT_EQ(0, reg.write_index);
> +
>  	/* Multiple registers to same name but different args should fail */
>  	reg.enable_bit = 29;
>  	reg.name_args = (__u64)"__test_event u32 field1;";
> @@ -288,6 +294,8 @@ TEST_F(user, register_events) {
>  	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSUNREG, &unreg));
>  	unreg.disable_bit = 30;
>  	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSUNREG, &unreg));
> +	unreg.disable_bit = 29;
> +	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSUNREG, &unreg));
>  
>  	/* Delete should have been auto-done after close and unregister */
>  	close(self->data_fd);
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
