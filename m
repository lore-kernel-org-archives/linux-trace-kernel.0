Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFC43D953E;
	Thu, 10 Sep 2026 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789034736; cv=none; b=cspzRpLmb6P2m4kl6n+6T8lj7bFVQUyltRhj1fsEGw5wEN7E67NDLkZMLkPRztD1yWkIAkGSkWYYBV/MPqBdsiuYCONlEP3voW4TD+aXofH8rL0gQfieBi9+ejuBiER0gx85D+AZxKo64bnoxfrL8Mfn/HzGfr2zFAg3KCutJjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789034736; c=relaxed/simple;
	bh=ETFRh3gaMY1GVhjn47txxgfiY2X8rAo39gmD9GinufQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IT8iMpytE3egRN/DCo3uVSNNSln8U1to/dWlN/339fxBbIiew97+mQGI3AOwg6UuzogGxEDOMjCUaiG1PEX62iuRLGW0S+phhJ0U5lmZfo3+HH64M3ABF/NM4ubAVj1GfD4sY9ZxRathQTqPQ37beToC216jZ4wt+km0Y4g98dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=cQZiuxcM; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="cQZiuxcM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JCmt/pLSQvD074W5u+2P7MUPzAJxdnB79RGOsuQtHAY=; b=cQZiuxcMq7V6vbk3/67ssRYZqQ
	tQdwB+IUKJ/G8r5PgOa8dB3AbCxHKS+9amN/gea9OJZgUIOBHqvXMax/znv+hcwKtYcJcCCN0JMog
	jlQYoLOSgnGQVdk5MqEyX3dTtqIpZHIATkZrsYCxGZTRAKARFrfOpnTX9qmKHPM1PrQvQl4ScV+QB
	caQL7SEHYlvqcMVfgusL6LsIRSQsbDaKJ/n6XVnBwDiUZGfV+nEouzNsZHmZH1/WeaprP3XSXMAhe
	KBCt6uDjKWE9/6B7kuHseYNaSCLPHBaTz54rOR3vMMJfC0q8AFoocxNTYdOEtyrygMZweuUINEaYl
	bidt+YfA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x4bef-000QyE-1g;
	Thu, 10 Sep 2026 10:05:17 +0000
Date: Thu, 10 Sep 2026 03:05:12 -0700
From: Breno Leitao <leitao@debian.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Douglas Anderson <dianders@chromium.org>, 
	Huacai Chen <chenhuacai@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: Re: [PATCH v3 2/2] bootconfig: Fix integer overflow in initrd size
 check
Message-ID: <aqKAzTzpqYmuj8Rm@gmail.com>
References: <178900555453.200943.4719889510443114485.stgit@devnote2>
 <178900557529.200943.11099215789605267709.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178900557529.200943.11099215789605267709.stgit@devnote2>
X-Debian-User: leitao

On Thu, Sep 10, 2026 at 10:59:35AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Sashiko reported that in get_boot_config_from_initrd(), a crafted initrd
> with a huge bootconfig size (such as 0xFFFFFFFF) can cause the pointer
> arithmetic:
> 
>     data = ((void *)hdr) - size;
> 
> to wrap around on 32-bit systems (or when pointer subtraction overflows).
> Because data wraps around, the subsequent bounds check:
> 
>     if ((unsigned long)data < initrd_start)
> 
> evaluates to false, bypassing the check. The kernel then calls
> xbc_calc_checksum(data, size), which attempts to read 4GB of memory,
> hitting unmapped pages and triggering a fatal kernel page fault during
> early boot. Furthermore, on 64-bit systems with an initrd > 4.29 GB, an
> unbounded 32-bit size can similarly bypass the initrd_start check.
> 
> Fix this by:
> 1. Ensuring the initrd is at least large enough to contain the bootconfig
>    footer and verifying hdr is within the initrd bounds.
> 2. Checking that size does not exceed XBC_DATA_MAX and does not exceed
>    the available space between initrd_start and hdr before performing
>    pointer subtraction.
> 
> Fixes: de462e5f1071 ("bootconfig: Fix to remove bootconfig data from initrd while boot")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260910010137.EE0431F000FF@smtp.kernel.org/
> Assisted-by: Antigravity:gemini-3.8-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>
