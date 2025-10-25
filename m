Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D4F30ACF7;
	Sat, 25 Oct 2025 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761420603; cv=none; b=gokeoF8UJaSBYhfec8yHCWGR9eD7XzOmNk+bGAmy3tndIvzoXYSX4ZTtr8Jk7MEwhkIgFEESh6oUaPEbGhZJLdBmN1Bpz8i6UwUO/D5vsf7Z234Ft/f+3xGycoJCEyUE9CQCL10hXvvohRgoEEMc/zowNtv9OhMHiuUwrNDO5Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761420603; c=relaxed/simple;
	bh=HxU5s3ru08zv2uPbKB02UZQtR9vvfSn+Asv3Z0hMD28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nx9SNHwDlA+6OK4PIsqRuFXp9Z2lmRCQH0HCTro/DpGW8pq9X457R9ZZXaYj21w3ENiUTGu8QO0Iqs9SIuPJVD3lokwr5i/nyfhm/se1hCeMDh2BB6M+RE2pECzPVpchMBBmpBTHeWJ+lwKnjk4QllqFKhHoTzdr13v+uItKNYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 0869C55EA7;
	Sat, 25 Oct 2025 19:29:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id C28B72002B;
	Sat, 25 Oct 2025 19:29:55 +0000 (UTC)
Date: Sat, 25 Oct 2025 15:29:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 13/21] trace: don't use GENMASK()
Message-ID: <20251025152954.25807ec7@batman.local.home>
In-Reply-To: <20251025163305.306787-6-yury.norov@gmail.com>
References: <20251025162858.305236-1-yury.norov@gmail.com>
	<20251025163305.306787-6-yury.norov@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C28B72002B
X-Stat-Signature: 7zzn91j7x648w9ms1fi99hpmtm7pcm6c
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/44D9yuHz9dVfvnBemYhEMxeRme8K4ZN8=
X-HE-Tag: 1761420595-616211
X-HE-Meta: U2FsdGVkX1+yPZXRQ7X8+V6Krgz8HOasdEpKO8wFjzn3Zvntb5fTNPZ2ZMx5ZcU8MevMlQ1P4y/SlhEF0Y+1iqWMcFwFXrVqo34BY1uoYfagq4CkrAxS7jLn6OFmM4K6lh9ZWCl/lkAjSuShL9ZhZc0h7RaOcS+nwwzQ1//n2sD/9zG30jTCQRUW/eUe675lCIcupxcJFnPDmgYyuICE4nnbPSEnHV8/8Z6UKATLL/6MAiYKVxCdyC6DIERgF2RnW4paQE3BWhw/ECzppRcZZHG0Z0h9FSSAroHcqxcJaTfh7a8kPQEDGQgF0XKasQWgO6riBOnhHj/BSsD//RdpJGGDhA8RJz8U

On Sat, 25 Oct 2025 12:32:55 -0400
"Yury Norov (NVIDIA)" <yury.norov@gmail.com> wrote:

> GENMASK(high, low) notation is confusing. FIRST_BITS() is more
> appropriate.
> 

I'm fine with this change as a clean up, but...

> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>  kernel/trace/fgraph.c      | 10 +++++-----
>  kernel/trace/trace_probe.h |  2 +-

Make this two different patches. trace_probe and fgraph go through
different topic branches.

Thanks,

-- Steve


>  2 files changed, 6 insertions(+), 6 deletions(-)
