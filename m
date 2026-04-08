Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335A321FF23;
	Wed,  8 Apr 2026 00:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775608579; cv=none; b=gK9hrdNWwllfiKX5fsNIuEqwr043g0Jm8wEbs7vEVfizQo8UhMDs/W6SiSK2BSj4Z5kF09I+PVJuOScOk/cM6/sKTilfp0+befU7eLnRwlNCadQtlV43RitgG2uB0svN6SPiS8yBWzooNqGcXEwsJZwHPKE0MZmqog1Gw/ySoEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775608579; c=relaxed/simple;
	bh=DSHMKtcMrFlc2mTpnSw9/onSDzVkuubQ5CqhnzJlKbc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBEB242w1asFr7KrpBBFMy9ZmpaJQPlS6ycBotTYnrvTP1Xp3SpkXNXO83VrmOzzBhhLQvTwlpP0bKLV5wo5Yr1ov6v3p3Gx++BmHREdAtBIUoxlQlgcdl1fhT6dbHyqRm3QEucwXeYl+ofaxI4u7PHOvRY4yufPQuiUgQEKn+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id AD3EE1A0A18;
	Wed,  8 Apr 2026 00:36:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 7A0B880014;
	Wed,  8 Apr 2026 00:36:13 +0000 (UTC)
Date: Tue, 7 Apr 2026 20:37:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: CaoRuichuang <create0818@163.com>, Shuah Khan
 <skhan@linuxfoundation.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Drop invalid top-level local in
 test_ownership
Message-ID: <20260407203727.442b583c@gandalf.local.home>
In-Reply-To: <20260407102613.81419-1-create0818@163.com>
References: <20260407102613.81419-1-create0818@163.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: nxms7hr86n7fhxgry7oowca85x1u35yg
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 7A0B880014
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/V1biiv5PEsKfAB4ePCeL1+ugMHb2vifI=
X-HE-Tag: 1775608573-971609
X-HE-Meta: U2FsdGVkX19TXhA7rYYC5HSaQAk4z9SqOsfhHTZUDcBiiOzF8BbuiGNT0cDkaEpPUOaaxEFq/5xiLwUNUN2g84kJU9lZNYAAa33gVPQYun/PC6B4T3KEnRaRo34kYzWb+t8e6r0coic1EncfSMh6BUyvIzrUgh3I15MIlr9oDkgSKkGiY1AMfh9zsKFXrSW5vlrpzZJ7jIuYeb8dx4Ri0UNLnRKK8DYolpWBiBl8yHqHoo5WRd6myD9L6H/nGvuv0WmhTM54X3UtXgxj4+SlSKI04w5HSGswKnxwjLBOJmcEBsgRsZ1JF2ce9DNBGlg5xGh1y43kf7VPQnU6b+v00KzCRdPiV8daHY5S40sRGqVEpO/bh/DOxsrbo27UvcuLWRbwd8/ODfY+gJYYg+tGwVyr3IA48ZJsLPbnOolZY8o=


Shuah,

Care to take this through your tree. Probably could even add:

Cc: stable@vger.kernel.org
Fixes: 8b55572e51805 ("tracing/selftests: Add tracefs mount options test")

As well as:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


On Tue,  7 Apr 2026 18:26:13 +0800
CaoRuichuang <create0818@163.com> wrote:

> From: Cao Ruichuang <create0818@163.com>
> 
> test_ownership.tc is sourced by ftracetest under /bin/sh.
> 
> The script currently declares mount_point with local at file scope,
> which makes /bin/sh abort with "local: not in a function" before the
> test can reach the eventfs ownership checks.
> 
> Replace the top-level local declaration with a normal shell variable so
> kernels that support the gid= tracefs mount option can run the test at
> all.
> 
> Signed-off-by: Cao Ruichuang <create0818@163.com>
> ---
>  tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> index e71cc3ad0..6d00d3c0f 100644
> --- a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> +++ b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> @@ -6,7 +6,7 @@
>  original_group=`stat -c "%g" .`
>  original_owner=`stat -c "%u" .`
>  
> -local mount_point=$(get_mount_point)
> +mount_point=$(get_mount_point)
>  
>  mount_options=$(get_mnt_options "$mount_point")
>  

