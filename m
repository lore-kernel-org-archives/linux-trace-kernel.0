Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EDB79C4;
	Sun,  5 Jan 2025 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736068384; cv=none; b=V0uw87mYagMeNmk2D0dty85z1y1Rf5UynI+JxXTxGw1jtaLayUQ/g2gk8vJBMRiVve/jOlwubtiTMmNWs7iH4y2kylofbnCHlOQnuKsrLh1ZeoUdjeDuM6nYemaM7aSWn394mCqveV211qP4ZgtgqbjqZ/D0PIPD3k5uQpmEaXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736068384; c=relaxed/simple;
	bh=cFDrJrFQat7Y2i+Vf8cz6jKVSQiPKjHN/9Ih4+lpcx0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kOjlEUvr3TNPDYZvftWK3/TKxw9prKLEYAoqrH99E7eBB5cIPMqwW6jAonPqevnt32QH9IA1gKNBXl4SFfyEHeHu9NQl8AQsG+0OvTegAqn0+JXxw+qotkqB4Of9QqNKHGaseKi44ocpqiDUfZ3rvu6I1/3EK0mjcB2DuRObDUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjXNmH0d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjXNmH0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38007C4CED0;
	Sun,  5 Jan 2025 09:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736068384;
	bh=cFDrJrFQat7Y2i+Vf8cz6jKVSQiPKjHN/9Ih4+lpcx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NjXNmH0d4Dn8z9hDSpZHKqYHv5/lbolhypCIXkyPfyRD6cNWU4x1Yrbiq+YYMziCm
	 SWRsL4cUK2j7EDDY+KOFDTpTtNsmgBiOIc6Qz2QFXG3UICS9EsIFsJDYwk04Oq9DEB
	 B5e9Td86gS0Bu0S+IeZ8d51L3mciuQwulWrlDavLxUiDsfxthp8tiZRM+cLs/PTm2t
	 LuCQnBB6PlzOVxWvuXHuDYmqYzaNa2/jkBAVdn/8UEyXBSmPjv0h+LTZ/eGNSPNg4U
	 f91+J9uEfpF31n1NRqVZ91MUW4NCxyO3DyF+G10+RxdomN6Y3HMa87LbeGHxe6P7Gx
	 qiBx5D1VIlTGA==
Date: Sun, 5 Jan 2025 18:12:57 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
 <peterz@infradead.org>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] Provide __free(argv) for argv_split() users
Message-Id: <20250105181257.7023ab6d018c7ff625edee31@kernel.org>
In-Reply-To: <202501041451.yG7LhbEv-lkp@intel.com>
References: <173594530753.1055889.17844868397124331132.stgit@devnote2>
	<202501041451.yG7LhbEv-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 4 Jan 2025 14:51:12 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Masami,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on next-20241220]
> [also build test ERROR on v6.13-rc5]
> [cannot apply to kees/for-next/hardening linus/master rostedt-trace/for-next rostedt-trace/for-next-urgent v6.13-rc5 v6.13-rc4 v6.13-rc3]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/tracing-kprobes-Fix-to-free-objects-when-failed-to-copy-a-symbol/20250104-070535
> base:   next-20241220
> patch link:    https://lore.kernel.org/r/173594530753.1055889.17844868397124331132.stgit%40devnote2
> patch subject: [PATCH 2/6] Provide __free(argv) for argv_split() users
> config: i386-buildonly-randconfig-001-20250104 (https://download.01.org/0day-ci/archive/20250104/202501041451.yG7LhbEv-lkp@intel.com/config)
> compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250104/202501041451.yG7LhbEv-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202501041451.yG7LhbEv-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from scripts/mod/devicetable-offsets.c:3:
>    In file included from include/linux/mod_devicetable.h:14:
>    In file included from include/linux/uuid.h:11:
> >> include/linux/string.h:315:19: error: expected identifier
>      315 | DEFINE_FREE(argv, char **, argv_free(_T))
>          |                   ^
> >> include/linux/string.h:315:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
>      315 | DEFINE_FREE(argv, char **, argv_free(_T))
>          | ^
>          | int
> >> include/linux/string.h:315:12: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
>      315 | DEFINE_FREE(argv, char **, argv_free(_T))
>          |            ^                            
>          |                                         void
> >> include/linux/string.h:315:42: error: expected ';' after top level declarator
>      315 | DEFINE_FREE(argv, char **, argv_free(_T))
>          |                                          ^
>          |                                          ;
>    4 errors generated.
>    make[3]: *** [scripts/Makefile.build:102: scripts/mod/devicetable-offsets.s] Error 1 shuffle=808271366
>    make[3]: Target 'scripts/mod/' not remade because of errors.
>    make[2]: *** [Makefile:1262: prepare0] Error 2 shuffle=808271366
>    make[2]: Target 'prepare' not remade because of errors.
>    make[1]: *** [Makefile:251: __sub-make] Error 2 shuffle=808271366
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:251: __sub-make] Error 2 shuffle=808271366
>    make: Target 'prepare' not remade because of errors.

Oops, I forgot to include cleanup.h!

Thanks, let me update it.

> 
> 
> vim +315 include/linux/string.h
> 
>    314	
>  > 315	DEFINE_FREE(argv, char **, argv_free(_T))
>    316	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
