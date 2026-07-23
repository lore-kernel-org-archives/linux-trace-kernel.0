Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E1C1C69D;
	Thu, 23 Jul 2026 00:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784766419; cv=none; b=Cd7AxQbb4Ot2io571P1sO6vG7150P8VS3cN9pSRj3AGQvDO3VZBEwCys2xaAVrTfo6ezUkA08rZWM/3iNi4kF7IU6ePT685FfCmWbVq/Du/ETlfCL1l6GYdfNwSdWIApnvxA/TTGw0E0DGU90KbSDyz0NzsIpN3lCtCt+YwandI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784766419; c=relaxed/simple;
	bh=ug5pEVgZ2P9TqU2q41E0/En1cj1e3gcoxjRCVCz2jRs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tg+jsfKGXSv3EZFw8Wczev/jqSyrIYZbwSIBnJY3zFZs/dPaDxlihZuO6fAcDZAH+YTi9KTf5zP7cwpOuiKgyOCTWg0LXGLR82A8XiwytSPnDIBW33tHRr3CE7U08QDa9aV2ZOkD6D1WMQLA2IHHM2N9UpK4exHzxA8Tiy+/eUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXYE9iI3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXYE9iI3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2641F000E9;
	Thu, 23 Jul 2026 00:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784766418;
	bh=nd75fgepznXQYIh/RosfLKtPne7ezYEigCutRJYcNPU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WXYE9iI3gWSFjH2b8404arOxg699D/ocATPRnuMyr83zggTv0xIS8eYdcyKE10/nS
	 wJBpjKkGGMYAmjF53AvXHGcGSfUAGqVI3VvTKvthhx1/RkBYsiMVgwCatYZ5o3NCXP
	 NgmpHvX4ZKxV4ZUwF858VvTaIcX8T2Jc6N4+Zh7XuFizXTgRtruDuoDDzwUcP1eq+6
	 T/6RiRLRfyiZ9RSrkpxDjtZIWKdJiqIv6PjbvV4ufhuFtmzIbSkXqlFGgpTpu2tzO2
	 i2aFYjeWtlCYk96yYzS6b5fo3lJ3fz/RpiIINdokadKlZ7iqHpf/GQm3udgyPCkeUa
	 Z3iXodcxrPMoQ==
Date: Thu, 23 Jul 2026 09:26:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, oe-lkp@lists.linux.dev, lkp@intel.com,
 kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] selftests/ftrace: allow relative paths in eprobe test
Message-Id: <20260723092654.12f7be2910e3e16259c61125@kernel.org>
In-Reply-To: <20260721200612.1749777-1-martin@kaiser.cx>
References: <20260721200612.1749777-1-martin@kaiser.cx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 22:05:59 +0200
Martin Kaiser <martin@kaiser.cx> wrote:

> The add/remove eprobe test installs an eprobe for the openat syscall,
> runs ls and checks the filenames that were opened.
> 
> Commit 206b25c09080 ("tracing: eprobe: read the complete FILTER_PTR_STRING
> pointer") fixed access to some string fields in eprobes. This allows for
> dereferencing more filenames. In some cases, the log now shows a file
> with a relative path instead of "(fault)". A relative path makes the
> test fail.
> 
> Relax the filename checks to fix the test. Allow shared libraries and
> locale configs that use a relative path.

Hmm, should we check this "nocontent" ? This change seems a bit fragile.
I think we should use another syscall to make sure getting filename
correctly. At least this point, removing nocontent check will be better.

Thank you,

> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202607151010.b68428e1-lkp@intel.com
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  .../selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc      | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
> index c300eb020262..baceeca7ccdf 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
> @@ -22,7 +22,8 @@ ls
>  echo 0 > events/eprobes/$EPROBE/enable
>  
>  content=`grep '^ *ls-' trace | grep 'file='`
> -nocontent=`grep '^ *ls-' trace | grep 'file=' | grep -v -e '"/' -e '"."' -e '(fault)' ` || true
> +nocontent=`grep '^ *ls-' trace | grep 'file=' | \
> +	   grep -v -e '"/' -e '.so' -e 'locale' -e '"."' -e '(fault)'` || true
>  
>  if [ -z "$content" ]; then
>  	exit_fail
> -- 
> 2.43.7
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
