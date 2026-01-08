Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC35204583;
	Thu,  8 Jan 2026 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888380; cv=none; b=DKEahUzLCK1AbAMTnq71jS+ljR+LHxnIdc3bCxjRJ1mmyq8zHdp1X6tyjL4P6nsqV9SL2nxFlqqabSgWkcrdgf7ZcB0P49EBSZ+Q3o4jDkvDHDCYZ0/bY8DvZvRVV+TP0zycZ/rAfW0XonUzlMTLgLV+Z0ukENW+rmSCUa/Q4Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888380; c=relaxed/simple;
	bh=UJWiJfJXZGYu0syNYpB3ssxGeGhaiTzlfLuo/sDcIWs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XqSsZH5XnmuEiX8HZ3Ic8eWq/ON6WfDqtGg87n61pRMvQnEFzWaO7PKoEyDNlPjNn1+GCIKsC9wIqB0LD7nB+/7xfgwUexrtbaWE2SZgS30XWU5hnpjybP4gxe59xU4jUHJ1l0gCoXzhmZR7YBW5ggAQNCj3sTilmfm0nGTLZrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id D2B3156593;
	Thu,  8 Jan 2026 16:06:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 549DA20010;
	Thu,  8 Jan 2026 16:06:05 +0000 (UTC)
Date: Thu, 8 Jan 2026 11:06:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux
 Documentation <linux-doc@vger.kernel.org>, Linux Kernel Tracing
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, Swaraj Gaikwad
 <swarajgaikwad1925@gmail.com>
Subject: Re: [PATCH 0/2] PCI tracepoint documentation fixes
Message-ID: <20260108110633.5691a824@gandalf.local.home>
In-Reply-To: <20260108013956.14351-1-bagasdotme@gmail.com>
References: <20260108013956.14351-1-bagasdotme@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 549DA20010
X-Stat-Signature: 1qpgjedwofunocicakofago1ted71wep
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Z3h8SZQXE23IaSbkjBGAD3lRZkv2KrgI=
X-HE-Tag: 1767888365-269768
X-HE-Meta: U2FsdGVkX1/EdKc4TQJTyXm6Nj/rEw3xpLXWHwd8FHWDc1stdE9+plpxOF7WhCqGXf3J/nsDwiKz5b6nEvUUof9NKcTtnhoufAjXXfHIdTdxBh8X4z+o4pgxLTDWnjd6zCfwR7fmKMfTDeMD12JdVm/3qf/q8cbBa2YBBBbl5WYTiDqD+h/QLx96dHySLte8qXhz1AS3zVT3ksq9/6xWy/EJ5xb9VGSemG6JwXrQiVBP5a3qR8M3G1AVLytRG/ApPe4aTbcOef4psexNjbe+Vn2CYLZ1djpoZv3OQOJL1ePbjDf19LMO2kVQyzM9EE9d4FnQmFRG028G1QrI9H8ihNMgnaRNJbpOOo7tAs6+5umrTjzKs+2YfkiqH7xP2ybPjfLR6hi8ZkmjxcohfxLcvj3XP9ejxKjSkW4ulpcKgGzCLSNuvvBoPdVBuow7SfF9FlcBYQ/ZAvIsikpVi50oefI8jvSDJmw6ob+i34QyytY=

On Thu,  8 Jan 2026 08:39:54 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> Hi,
> 
> Here are two fixes for htmldocs warnings on PCI tracepoint docs as reported in
> linux-next [1]. The shortlog below should be self-explanatory.
> 
> Enjoy!
> 
> [1]: https://lore.kernel.org/linux-next/20260105160000.0368ec8d@canb.auug.org.au/
> 
> Bagas Sanjaya (2):
>   Documentation: tracing: Add toctree entry for PCI tracepoint
>   Documentation: tracing: Wrap PCI tracepoint examples
> 
>  Documentation/trace/events-pci.rst | 4 ++--
>  Documentation/trace/index.rst      | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> 
> base-commit: 29a77b4897f1a0f40209bee929129d4c3f9c7a4b

Fine with me. Jon feel free to take these patches.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
