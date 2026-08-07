Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6446318B9C;
	Fri,  7 Aug 2026 01:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786067236; cv=none; b=mfNNZJ+UNrWf/eBmrqA8CzXw9yF9UKnudeNll1xp6/cPhqrrz0Ky9H/JClucKgbPu4XY2svQB4hFD09JIjq8LAr3Pt0TDF/iPVW1PJWkdyKjAYQVjJTA47ZmeCg1Slnsgw0sN2Mll8CSxnlAieRBMfn/zEv/xC5eoAgjIMxyBcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786067236; c=relaxed/simple;
	bh=kLIMip2knq7l/LsG5q5r5BLHNf6pR93bHWwlSm/jgiU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YKWuHhsaoR1/IRuAWIPU5yf6yHMHpERSEaRoQuTUJApWZbl2GYyfv+47bc1zNQcZQcK7Dl+1KhFBQwP3zNrC+U0FTguMvHrNpWAEUcw7lEhDa86CpQhKaL6jAdP+5ABFwJaCvppvTGbbhtJh/b2o6y6VTOH1FtIiDZy5Ut+xbfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nR+VomWT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nR+VomWT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EADC1F000E9;
	Fri,  7 Aug 2026 01:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786067233;
	bh=kf1OV3Il8VP3xZXrq2TQNvTVMeSx61D33R9HJBu2lao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nR+VomWT4O+Khtn6wMeASPGXZFVRTWMUZxOPWHUbDHsrr2CzUiPLIpH57Zf0dhLsn
	 TLEgu0c4w3OigdpdQNCtCPkCnXxo4nZa4BKU4SYgf1EaI7hs4QztrXdZGe+NPKQn1R
	 iglNNHGy47iOWp10Xl3p46+IcC+7SaiGH5J6I8cG5BKmXPVa3rDL86udUvstZw+ay1
	 LaKiPjcVtZyH2Zb+cLo2Zw0qr/i6q5EK5wXKAvYOdykRuzpp7iA+9c64r4ZVSU/UYS
	 mBRZoS2sqwTin+4t141k5ABi/xxb27Hj8UYtn/MsCx796xB18PDUIm4Ck5l5JdhACE
	 DcIekRBZ2R7QA==
Date: Fri, 7 Aug 2026 10:47:09 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Rui Qi" <qirui.001@bytedance.com>
Cc: "Steven Rostedt" <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Shuah Khan" <shuah@kernel.org>,
 "Heiko Carstens" <hca@linux.ibm.com>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] selftests/ftrace: Force C locale for readelf in
 uprobe test
Message-Id: <20260807104709.0626fd20ed7618273dcbead2@kernel.org>
In-Reply-To: <20260806083101.2651025-1-qirui.001@bytedance.com>
References: <20260806083101.2651025-1-qirui.001@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Aug 2026 16:31:00 +0800
"Rui Qi" <qirui.001@bytedance.com> wrote:

> The add_remove_uprobe test parses the entry point from readelf -h output
> by looking for the English "Entry" field. readelf output is localized
> via gettext, while the ftracetest runner does not force LC_ALL=C and the
> top-level Makefile leaves LANG effective for child processes.

Hmm, to make it safer, I think we should force LC_ALL=C in the top level
of ftracetest, instead of setting it in each test case.

Thank you,

> 
> If readelf prints a translated field name, ENTRYPOINT becomes empty and
> the uprobe_events write is rejected because the offset after PATH: is
> missing.
> 
> Run readelf with LC_ALL=C so the parsed header field remains stable
> across locales.
> 
> Signed-off-by: Rui Qi <qirui.001@bytedance.com>
> ---
>  .../selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
> index f2048c244526..f33a863be68b 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
> @@ -12,7 +12,7 @@ echo 0 > events/enable
>  echo > dynamic_events
>  
>  REALBIN=`readlink -f /bin/sh`
> -ENTRYPOINT=`readelf -h ${REALBIN} | grep Entry | sed -e 's/[^0]*//'`
> +ENTRYPOINT=`LC_ALL=C readelf -h ${REALBIN} | grep Entry | sed -e 's/[^0]*//'`
>  
>  echo "p:myevent ${REALBIN}:${ENTRYPOINT}" >> uprobe_events
>  
> -- 
> 2.20.1


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
