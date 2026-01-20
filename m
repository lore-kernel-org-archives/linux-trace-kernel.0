Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F4D451065;
	Tue, 20 Jan 2026 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768942274; cv=none; b=tG9FceCrWQEMFKDZQ/LJtSRtPDFOjqm1wE4J1Wi9nCPcv4aL+rQHFYFJEvq3ZNLA+5fxRU27zTCaPVsU9gY/XszF5U1VwhftlVC7b7KRiz02YX/Z6dewGcVNV7jQx4ZMe9fs4LXuoCun0sQc+cuW6tcSn4k2sTDkQYlCRXrC/RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768942274; c=relaxed/simple;
	bh=oXYaidu2iknev+sua93Ff0yQrh5MnScXTEVXUGIC+gs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8FlFl3xjpJR9Hq9hqsSTiZEqjX08LZnDD82PcTng1+tWUzU78LCFcwqoq/9v0oPMyCzbV+nPUdMaHKurb+1oK6uUktIPhycgnI01zt3nRBoSgLeJ8z5xGGcTPAniK9uEsYknjt9NNmhPwaRiGMonaAlahLqgInA7xv4eDq0RtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 464721A0707;
	Tue, 20 Jan 2026 20:51:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 2C3522002D;
	Tue, 20 Jan 2026 20:51:07 +0000 (UTC)
Date: Tue, 20 Jan 2026 15:51:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Cc: mhiramat@kernel.org, corbet@lwn.net, shuah@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 3/3] selftests/ftrace: Add accept cases for fprobe
 list syntax
Message-ID: <20260120155128.6e95bc5d@gandalf.local.home>
In-Reply-To: <20260114221341.128038-4-seokwoo.chung130@gmail.com>
References: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
	<20260114221341.128038-1-seokwoo.chung130@gmail.com>
	<20260114221341.128038-4-seokwoo.chung130@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 2C3522002D
X-Stat-Signature: 48jtbm8qegjpri8ozd3tjwfyte8w4ho7
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19VzkR3s1zOIlWac9yX95pZyL4y1b6aI48=
X-HE-Tag: 1768942267-533393
X-HE-Meta: U2FsdGVkX1/fju3bH/LMM33WEb8eJtq3/cCksUMh+1/KJzLNvjcyF+tulARSmK9eu2AHnIE6lf9xMRnDuueIg6UbBk/+hfyiSwx+hFssay6U0sfy40htSkeh+orco/Gxp5cRgfQ3OrEun16DomXRcCD5/oJjjiUBWKLcqAIMmc246xop0jNsfbMd4e4LAElyyyF4Jcokw9TQ2Qpw4F0UPefmjObLZhbK1pr6WcuEpB1/WiiJWMwVCtwMRSVMDC6mfH+e/PAtiW4zkpmj64LhmR6hvJkSPm7o+hxCdt+GMpsa2ZqwShYTjbfJ5SgCtzvTsAbcRUyO6CPR+iS6WSc5XPJy46RGF2P9qoCnm+SKvabIyVK4csfS38e6kQUdPgku

On Wed, 14 Jan 2026 17:13:40 -0500
"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com> wrote:

-ENOCHANGELOG

 :-(

-- Steve


> Signed-off-by: Seokwoo Chung (Ryan) <seokwoo.chung130@gmail.com>
> ---
>  tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc
> index 45e57c6f487d..79392e268929 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: Fprobe event list syntax and :entry/:exit suffixes
> -# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[:entry|:exit] [<args>]":README
> +# requires: dynamic_events "f[:[<group>/][<event>]] <func-list>[:entry|:exit] [<args>]":README
>  
>  # Setup symbols to test. These are common kernel functions.
>  PLACE=vfs_read

