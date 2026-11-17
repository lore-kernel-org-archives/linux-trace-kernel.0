Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.77.101.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794917528;
	b=LA9tnveJxO5j4WUrbrw0QdGfc1eMiEPg2G1LwdqaQcJTY7fvsPZi19EapAn0DHt/y2hu
	 It81HDzc97kIAo5zik+lnHv7iQ3fK02NJd1JaQav6b4iNwljI04qCTNIrml3i7mKagC/Y
	 bNQZW1G5eraC524+UfzT5VEc25v9vLkweYKKacY5rhH92BtiD7v7zD8Bp/+w+3euNK7nc
	 xpg8f8QU1YtvovGs+XEUOCAat8GxWKvpiNyGqUGcUq0Wl0KkXtwnZofLx9970YHilGjxb
	 64agNcqf50HrAxc3JtdZAVNlYxZ6OaW/FM7ALW8X1F7IJeK433BSZt5Vnbhrz8Go0UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794917528;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-WP-MailID:X-WP-AV:X-WP-SPAM;
	bh=lj9OagPSRJNvuPdGLWpYCPjIPPY/8eEyHeaFsrygvcA=;
	b=XF99OwdL2Az63ywaowuWyuzEGNU9nzBIOx7pw3MjO87bWQd2AO+G12mfK5tyVudPN3jC
	 kf2KWYF2h7xeYApWEErQqW89P2OEqO6l35p71IptLE+PQ0DUKALyNHYeRe57WTJYoppZj
	 yZ/5H/pxKwzzfIF2tPCbPm/2KycqPdfS7LWFcwGwPK/h2kFEdkr7ahF3qULQKPdJhSE27
	 Z9Iv+w/dftD7rRfUDLEe+XkWj1kkKu24tAPUGqVNJu6zyROfwcM84TBX+fKz1Pq90+a4A
	 4w11ac+Px94dZu3N0ecBM2gfkjbHM/Y33I9zFt2YC9q0j0NOw9vTW9eSDRyRb0euJCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wp.pl;
	spf=pass smtp.mailfrom=wp.pl;
	dkim=pass header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=s20261001 header.b=jlgRi2Cz;
	arc=none smtp.remote-ip=212.77.101.12
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D122C606A31C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 12:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D122C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=s20261001 header.b=jlgRi2Cz
Received: (wp-smtpd smtp.wp.pl 8210 invoked from network); 17 Nov 2026 13:12:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=s20261001;
          t=1794917525; bh=lj9OagPSRJNvuPdGLWpYCPjIPPY/8eEyHeaFsrygvcA=;
          h=From:To:Cc:Subject;
          b=jlgRi2Cz/vVIwgREakUwVS49sHWLB7aN7h7CfhjIj8hgRoJdvFDpuemdEJaaQWwiy
           dv6H+g5JUTUe7bna0U+ZEuLGGD3ivvaHT5aYkCLA37aVE0naYwhKWc+fMGMbJqvn4n
           OY3PoxhoDsCkSAYYOx9wcabMT+LCqb6fRUmuLcF0bgz7bhUcmZa39D2UcyEuFwKdBj
           gnKIWHao6SFiQh4sbj97f1n7eF9nY1RfajMxe/2eXHHo4MfMt0g85h6FC4grEYgvBz
           +MT/z8JqAEQJ7MKF8RGMb5Rb7h/bmkkGJjN+aLVkyklihZhinWd3LFhUgRN4GYKugV
           GP2gKmLvNH+aw==
Received: from localhost (77-236-5-223.static.play.pl [77.236.5.223])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <pmladek@suse.com>; 17 Nov 2026 13:12:05 +0100
Date: Tue, 17 Nov 2026 13:12:04 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-modules@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jordan Rome <linux@jordanrome.com>,
	Viktor Malik <vmalik@redhat.com>, Miroslav Benes <mbenes@suse.cz>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v2 2/2] module/kallsyms: sort function symbols and use
 binary search
Message-ID: <avxElFF4GY1Jhk02@wp.pl>
References: <20260327110005.16499-1-stf_xl@wp.pl>
 <20260327110005.16499-2-stf_xl@wp.pl>
 <afnhidn7K7dZ_cPh@pathway.suse.cz>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afnhidn7K7dZ_cPh@pathway.suse.cz>
X-WP-MailID: 53ea68bc8316ef981b297076ee5d6f3b
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [sTNU]                               

Hi

On Tue, May 05, 2026 at 02:24:41PM +0200, Petr Mladek wrote:
> 2. Livepatches _rely on the sorting_ of symbols in the module.
>    The special relocation symbols might define a symbol position,
>    see
> 
> 	.klp.sym.objname.symbol_name,sympos
> 
>    in the documentation. It defines the position of the symbol
>    when there are more symbols of the same name, see
>    klp_match_callback() in kernel/livepatch/core.c.
> 
>    I am afraid that _this patch might break_ this when it moves
>    function symbols before non-funciton ones. I guess that
>    the symbols of the same name will not longer be groupped.

Thanks for pointing this out. It took me quite a while to understand
the issue, but I finally got it.

> Idea: Is the shufling really important for the performance, please?

One reason I wanted to shuffle the symbols was to also speed up
name-based lookups, assuming that most lookups are for function
symbols. Moving them to the beginning of the table reduces the
number of entries that need to be scanned in the common case.

In my benchmarks, this reduced the average time spent in
__find_kallsyms_symbol_value() from 16 us to 6 us. 

>    I would expect that binary search would have a good performance
>    even without the shuffling. It puts aside half of the symbols in
>    one cycle. 

I'm now going with a separate sorted index table, leaving the original
symtab untouched.

I think the name lookup optimization could be revisited later by
introducing a new function that uses the index table to search only
text symbols, where appropriate.

Regards
Stanislaw
