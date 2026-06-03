Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50823D9028;
	Wed,  3 Jun 2026 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503439; cv=none; b=IFhlPEnMgka89cpGuJWy03TA3DEgKogm7EP/gqtG7Vek42rtvzfdLCu6HeQVu2vMGkW58cEw8N1n2YgaOH4WGwwpDRsD3EerF7MzBWDp2k1VWDRNZoiijiGdrLQ5s73Ny10vvdiqQlEz4yUOxjttqQilU6xtHNlYrBQ88B4fPK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503439; c=relaxed/simple;
	bh=oFJ0I7c8IRKtvheN2lLRAc9vrx9iFyNX05vWU1a35jE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUk1Jrl9J3B7b4DWvM5F6B8pVmQGW/S578iXuwJGY213Tdfdu0ofKIA02ocMlYgzsHcMgzpxY3Ji2ivBAcc05QE5EGTOBs7Gd4xaEVFMoiv/gEGCBWeHpv4A3K7f+0RbTWesW8MK1SljQXAA1VLghpll0HWE9zeW8Lf2UVO82S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id EE67D4046F;
	Wed,  3 Jun 2026 16:17:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 1CB8C17;
	Wed,  3 Jun 2026 16:17:07 +0000 (UTC)
Date: Wed, 3 Jun 2026 12:17:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "mchehab+huawei@kernel.org"
 <mchehab+huawei@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
 "bp@alien8.de" <bp@alien8.de>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
 "xieyuanbin1@huawei.com" <xieyuanbin1@huawei.com>, "Lai, Yi1"
 <yi1.lai@intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
 <linux-edac@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mm/memory-failure tracepoint change breaks userspace rasdaemon
Message-ID: <20260603121707.7eccb9fb@gandalf.local.home>
In-Reply-To: <b930678d-a1ae-458c-8705-7ca9680d4cb6@kernel.org>
References: <CY8PR11MB7134346A3E4BB28ECA28D6E989132@CY8PR11MB7134.namprd11.prod.outlook.com>
	<b930678d-a1ae-458c-8705-7ca9680d4cb6@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: pa3ma5qhsjqu49awbk79oorp7gqmdrcw
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 1CB8C17
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Y0GCOrJZJoVDEDn/Ri6LOhG4txmh7D10=
X-HE-Tag: 1780503427-767641
X-HE-Meta: U2FsdGVkX1+2ifXGDugSNwAKZybwNq+9PxgoHWGdVhxv/lrTyh8JwFDrTn44NWmCU5r4q4m5vzrOvnMvLqBnff4SfGmqK1pEw8YoKykgGzU0UXgxg+qdTzmvxBKIRUXUl6olCkZkYm0E8U39MQwDRuz5bcxEqKxx3Tvq8DawBVmTksaiy72WLoaQTS9SUwLIqM6axn8J4qsmuea1RyhKFGw/oPCw1L0h0f0wpU4/4tzhKquBYxQjOTXjC4eM2psgo6ndtw7HQIcO9M9zi4KcerpR4eI3IwucdL8nbC9MttmLSCpUg7S8QgQbVP331LPW0hIUKcIcspp62UblYaMBJbYj8wjZ5jLsko9MM8g3XSmyg4EQAC0r9Bqi5TC1UhULcPZA7eagucrrZPyz1XqPBoFX/Gp7EtlH//6Z6fG30vxTal6/brvBA5L4rMLU5liawh9IBc8CDCQw5Hvu0UL6sPctwCp1AlJyKfUvWfTVn0tiEuOfTjPK6n/cVYhFjg9c

On Wed, 3 Jun 2026 15:44:54 +0200
"David Hildenbrand (Arm)" <david@kernel.org> wrote:

> Likely the latter. BPF [1] documents:
> 
> Q: Are tracepoints part of the stable ABI?
> A: NO. Tracepoints are tied to internal implementation details hence they are
> subject to change and can break with newer kernels. BPF programs need to change
> accordingly when this happens.
> 
> The Kernel ABI document explicitly doesn't list them AFAIKS.
> 
> There were previous discussions on the stability of tracepints [2], I don't know
> what changed in the meantime. CCing Steve
> 
> [1] https://www.kernel.org/doc/html/latest/bpf/bpf_design_QA.html
> [2] https://lwn.net/Articles/747256/
> [3] https://www.kernel.org/doc/html/latest/admin-guide/abi.html

Tracepoints are not stable or BPF programs only. But other applications
they are[1].

Adding Linus as he's the Supreme Judge on the matter.

-- Steve

[1] https://lwn.net/Articles/442113/
