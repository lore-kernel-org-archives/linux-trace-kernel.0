Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B9D194A74;
	Mon, 18 Nov 2024 23:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731972468; cv=none; b=t56bpbd6lSWJj+cXle+8ywvWJHWvboqXShZAbiVrZaMpfbAAuVo0N/wBvTPhYFkZYpf4SMx80/epnYj6XHEul2BkeuEid/tuTygEyOUzgtyfqdIQXgrwIdPkkRqQub31p9xdRU9NwGcf+lKNqVLeqQJ86dLkQ/oxNUWXOzs44zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731972468; c=relaxed/simple;
	bh=OGpC46iTi3Y1cD4+Bs65U9IcYWK9htPKpQuAe+iuWW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m8rLUvesuYpKA3PcTJH67zsgpalJmk6BzTAlR1W+sGgKUMvmnrkduk6rN6W8ZDW4hD8g+e7iZtgDdBS3oG0g3N5aA6pO/EeCRHOuVwFvI1TKCF5qMy8jLlgGutemY3DCcYJWqJHlJw7MYAw2xwRkpMnWW56RyvkfxCqxmlxRRzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267C6C4CECC;
	Mon, 18 Nov 2024 23:27:47 +0000 (UTC)
Date: Mon, 18 Nov 2024 18:28:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: lkp@intel.com, boqun.feng@gmail.com, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, ojeda@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] jump_label: rust: pass a mut ptr to
 `static_key_count`
Message-ID: <20241118182818.7717993c@gandalf.local.home>
In-Reply-To: <20241118202727.73646-1-aliceryhl@google.com>
References: <202411181440.qEdcuyh6-lkp@intel.com>
	<20241118202727.73646-1-aliceryhl@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Nov 2024 20:27:26 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> When building the rust_print sample with CONFIG_JUMP_LABEL=n, the Rust
> static key support falls back to using static_key_count. This function
> accepts a mutable pointer to the `struct static_key`, but the Rust
> abstractions are incorrectly passing a const pointer.
> 
> This means that builds using CONFIG_JUMP_LABEL=n and SAMPLE_RUST_PRINT=y
> fail with the following error message:
> 
> 	error[E0308]: mismatched types
> 	  --> <root>/samples/rust/rust_print_main.rs:87:5  
> 	   |
> 	87 | /     kernel::declare_trace! {
> 	88 | |         /// # Safety
> 	89 | |         ///
> 	90 | |         /// Always safe to call.
> 	91 | |         unsafe fn rust_sample_loaded(magic: c_int);
> 	92 | |     }
> 	   | |     ^
> 	   | |     |
> 	   | |_____types differ in mutability
> 	   |       arguments to this function are incorrect
> 	   |
> 	   = note: expected raw pointer `*mut kernel::bindings::static_key`
> 	              found raw pointer `*const kernel::bindings::static_key`
> 	note: function defined here
> 	  --> <root>/rust/bindings/bindings_helpers_generated.rs:33:12  
> 	   |
> 	33 |     pub fn static_key_count(key: *mut static_key) -> c_int;
> 	   |            ^^^^^^^^^^^^^^^^
> 
> To fix this, insert a pointer cast so that the pointer is mutable.

Hi Alice,

BTW, how do you test the sample tracepoint? I see you add a tracepoint in
the module load call, but currently we can enable module tracepoints on
module load. How do you enable it when the rust_print module gets loaded?

-- Steve


> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202411181440.qEdcuyh6-lkp@intel.com/
> Fixes: 169484ab6677 ("rust: add arch_static_branch")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/jump_label.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/jump_label.rs b/rust/kernel/jump_label.rs
> index 2f2df03a3275..b5aff632ecc7 100644
> --- a/rust/kernel/jump_label.rs
> +++ b/rust/kernel/jump_label.rs
> @@ -26,7 +26,7 @@ macro_rules! static_branch_unlikely {
>  
>          #[cfg(not(CONFIG_JUMP_LABEL))]
>          {
> -            $crate::bindings::static_key_count(_key) > 0
> +            $crate::bindings::static_key_count(_key.cast_mut()) > 0
>          }
>  
>          #[cfg(CONFIG_JUMP_LABEL)]
> 
> base-commit: 22193c586b43ee88d66954395885742a6e4a49a9

