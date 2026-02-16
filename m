Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5C11F30A4;
	Mon, 16 Feb 2026 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254854; cv=none; b=TCszzBr8b3iNi6aBEwRvj2L6jkSZ41QQM92SPWedeFVGM8yQWecQmunbR7Jc0ynYvH/qmoqAzlkYaKINGRdOzFXAYk5cS79KFKNQ05J7MZnV4UOzo0AZ+Jhg/MQ1sN2YKid/txUgvGH08Wf5sXBf19lbU5IcXmDMEtlQRh2j1vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254854; c=relaxed/simple;
	bh=fRPjhfsZS2cOLmYLg/JJlqUM6NQvahWGWGymMIQhatY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUJXVOL3XiUVbMa8m3Ic67VlXB4SDWbv5CuLhz4PqpWninafAPqw4i65ehVve5YSi2PCA8D5HZKdK0G50+vh00IwkcwXLmej3U/MNCtIUHCr9dLJp8WuzTRKL4bAuXfpN4xkR37ap1e0JhoVAhaYnXOG1UOOHRes26chvJVHEDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 654CE140DB0;
	Mon, 16 Feb 2026 15:14:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 8D11680009;
	Mon, 16 Feb 2026 15:14:03 +0000 (UTC)
Date: Mon, 16 Feb 2026 10:14:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Daniel Bristot de Oliveira
 <bristot@kernel.org>, Nam Cao <namcao@linutronix.de>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rv: Fix multiple definition of
 __pcpu_unique_da_mon_this
Message-ID: <20260216101402.6965ff73@gandalf.local.home>
In-Reply-To: <20260216090141.757726-1-mikhail.v.gavrilov@gmail.com>
References: <628790bb5ee45c8968550a54388862f020d014ff.camel@redhat.com>
	<20260216090141.757726-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 87t1p9jbab8sp35nbgmdcg6kni3a1h6g
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 8D11680009
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1//ojl5U+y4kjnWD+unCt/oudsU+51TuO4=
X-HE-Tag: 1771254843-695029
X-HE-Meta: U2FsdGVkX1/fESLPVzWpE3ZHJ/laKR3toVw3V6hM2I9iIeZCkKJSdS2VunlgL0i/s9yDBAGY5ZxlOJFEa1I5iOOaOdMEOPJI/kVMK/XW/CaP4/TW3w1oe7yIgU1K2+1nRo4mckX9oBXBUMRpKKTW/cogvfUfMCR3MWBE27no4/j8OgaOxCcueu9PtS6hUzADXBD+J8gRWBnkwtgDPiw/rK6160c/uYKLA8idIekBcaIlCeLJ0N5Da8Jyy4Zop0DJgiwThHKaRoqvpg1h1fLL9fES8/YTA6ncBsFflGjHVetnKAnFNKdNBW1gEmMkYXYSS4332doJLin8R0J9S79JThMrXm6lhx5/s/4h/bNrMn2XY5zW+ERPXe1PYlC3AKWed/1rIwUKM3g=


FYI, please send new versions of a patch as a separate thread. Do not send
it as a reply to the first version. That makes it much more difficult for
maintainers to keep track of.

You should also add what changed since the first version:

> The refactoring in commit 30984ccf31b7 ("rv: Refactor da_monitor to
> minimise macros") replaced per-monitor unique variable names
> (da_mon_##name) with a fixed name (da_mon_this).
> 
> While this works for 'static' variables (each translation unit gets its
> own copy), DEFINE_PER_CPU internally generates a non-static dummy
> variable __pcpu_unique_<n> for each per-cpu definition. The requirement
> for this variable to be unique although static exists for modules on
> specific architectures (alpha) and if the kernel is built with
> CONFIG_DEBUG_FORCE_WEAK_PER_CPU (e.g. Fedora's debug kernel).
> 
> When multiple per-cpu monitors (e.g. sco and sts) are built-in
> simultaneously, they all produce the same __pcpu_unique_da_mon_this
> symbol, causing a link error:
> 
>   ld: kernel/trace/rv/monitors/sts/sts.o: multiple definition of
>       `__pcpu_unique_da_mon_this';
>       kernel/trace/rv/monitors/sco/sco.o: first defined here
> 
> Fix this by introducing a DA_MON_NAME macro that expands to a
> per-monitor unique name (da_mon_<MONITOR_NAME>) via the existing
> CONCATENATE helper. This restores the uniqueness that was present
> before the refactoring.
> 
> Fixes: 30984ccf31b7 ("rv: Refactor da_monitor to minimise macros")
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---

Changes since v1: https://lore.kernel.org/all/20260216074727.741822-1-mikhail.v.gavrilov@gmail.com/

- <list changes here>

>  include/rv/da_monitor.h | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index db11d41bb438..7511f5464c48 10064


This way this patch has a link to the previous version. Then when this
patch gets committed, it the commit has a link to this patch, and that
patch has a link to a previous version and the chain of updates is archived
nicely.

-- Steve
