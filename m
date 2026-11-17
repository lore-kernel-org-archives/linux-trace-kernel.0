Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.77.101.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914277;
	b=IVmAermTLwq0yg13MzpSXFJyuYsXMx9l6Ekm0Fjd48sBOI24U+r+u25O12ghmHEneLoJ
	 8YPdaEB1Iufy8R4fhG5Z3aU5fCbLPGylnH3bMTPRl6ETdAXQRibpNVt8zh4ZceDNuIkRB
	 5SUAJcN+O5ycTDeM6VKm5UCRccawfy8QdVzMU40aqffzs+VeqpBmg49Z8bviAQhOWf9t4
	 yzMUQ7khiRyqEskrXOUBthJaHC7EgJpZcFPDcDRKfj6eoKPfvVLxD8apkTjAkPwe2ZvZ/
	 cmWYL18onDqqARnLs5fRU43ktsXgkQhZc8TJDspZmOr+Mnq2EWFi6twfu8EaH+7dSEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914277;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:X-WP-MailID:
	 X-WP-AV:X-WP-SPAM;
	bh=lacrfJAZc9PxSg1vvmhQyROqUQhgxiKoLysqHqcOGXI=;
	b=t/Hg2OyxJ0xEmXyFJ8f2zMOlxRf98PonwLct3h5ByA3OGavAPYPRkrTpDmh9MiFjCR8P
	 eGOcOMZR7VNUpc/0QxJIqqz+Q3ONkSv1XPC+wHN7jZT8w/AE+aL6csG1T5j9zs+4bgMXV
	 gPsdUr63sLCftZuKuYeDFT7X0zCOWVFglEMBPXPEDEVQVcPz/toecAp+vAR5sc38V2TbS
	 +Wgiv5yd6211Ir4HhWJP47QKdX2NStdrUAftf3mCaLzNpguR425+FsrTD4Lhu4U8D6sDH
	 HpFPpQc+DcefsK37bxPGIL0/yRry0jcMts7GuatTc38ftl5P1B9xcyyRhRO1Gg/IK/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wp.pl;
	spf=pass smtp.mailfrom=wp.pl;
	dkim=pass header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=s20261001 header.b=krDZcyq4;
	arc=none smtp.remote-ip=212.77.101.12
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AC1606A323
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 11:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38AC1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=s20261001 header.b=krDZcyq4
Received: (wp-smtpd smtp.wp.pl 27972 invoked from network); 17 Nov 2026 12:17:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=s20261001;
          t=1794914273; bh=lacrfJAZc9PxSg1vvmhQyROqUQhgxiKoLysqHqcOGXI=;
          h=From:To:Cc:Subject;
          b=krDZcyq4M6w44sq/2G7++7hEuIo+5D8uenjztHEL3QyX5QpiXYR1+QDZTsEbKFx5A
           zbDQ5lm6rswxursNM2fcLIX7id4AisJV+kPNkF/FOtwwtXPRGuswG3zF47VS7ZUmOt
           GqygzPVKHffCad7cT5e1lxbat1NzHYjKsyz+8gAobfYm+sS8ZKDNSBjA+DvsPcqKnE
           DSs95DOZ+X17zBaxfMcjt5vrfSG2LcpyLeM0K0LqDjlMbkUmyLnAHDMjxkrnTypxPy
           hWYv8Y7QDHdkhyOH55CweX1lYo4P00iFpd31vgm9WKYtE8z3HGQoaHJosdPjy8/h4d
           qbo6KSG9U52rg==
Received: from localhost (77-236-5-223.static.play.pl [77.236.5.223])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <petr.pavlu@suse.com>; 17 Nov 2026 12:17:53 +0100
Date: Tue, 17 Nov 2026 12:17:52 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jordan Rome <linux@jordanrome.com>,
	Viktor Malik <vmalik@redhat.com>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 2/2] module/kallsyms: sort function symbols and use
 binary search
Message-ID: <avw34F1WLGdyYUkN@wp.pl>
References: <20260327110005.16499-1-stf_xl@wp.pl>
 <20260327110005.16499-2-stf_xl@wp.pl>
 <11c8e139-f9f3-4b22-863a-4e021a3947e7@suse.com>
 <20260424091330.GA31168@wp.pl>
 <88ae41dc-e5e0-442a-9b95-5125adf31e75@suse.com>
 <20260428082330.GA2757@wp.pl>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260428082330.GA2757@wp.pl>
X-WP-MailID: f9197c6689b43e0d8ad86c0c3de46d46
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [oaPU]                               

Hi,

My apologies for the very long delay in responding.

I wanted to understand the livepatch relocation issue before getting
back to this patch, but I kept struggling with it and putting it off.
Eventually, I got some help from AI to understand how livepatch
relocations work and why reordering symtab entries breaks them.

On Tue, Apr 28, 2026 at 10:23:30AM +0200, Stanislaw Gruszka wrote:
> > >> I'm not sure if it is ok to limit the search only to function symbols
> > >> when the address lies in MOD_TEXT. The text can theoretically contain
> > >> non-function symbols.
> > > 
> > > Yes, the patch assumes that the only valid symbols in the MOD_TEXT
> > > are functions. If there are defined OBJECT symbols in .text, the patch
> > > would break lookup for those.
> > > 
> > > While it’s theoretically possible (e.g. hand-written assembly placing
> > > data in .text ?), I’m not sure this is a practical concern. In general,
> > > having data in executable segments is discouraged for security reasons. 
> > > 
> > >> Could this optimization be adjusted to sort all
> > >> MOD_TEXT symbols (excluding anonymous and mapping symbols) and move them
> > >> to the front of the symbol table?
> > > 
> > > That’s possible. We could track .text sections indices in
> > > __layout_sections() and include all valid symbols from those sections,
> > > and also reorder typetab accordingly.
> > > 
> > > However, this adds complexity. I would prefer to first confirm whether
> > > OBJECT symbols in MOD_TEXT is a real issue before going in that direction.

It turns out that identifying MOD_TEXT symbols is straightforward.
The section's memory type is already encoded in
sec->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT, where sec is obtained from
the symbol's st_shndx.

> > I'm not aware of specific OBJECT symbols that end up in MOD_TEXT.
> > Nonetheless, it is a valid case and it is preferable that an
> > optimization doesn't break their lookup by address.
> >
> > In general, I'm worried about the several edge cases and inconsistencies
> > that this optimization introduces. This also includes the fact that it
> > doesn't work for livepatch modules.
> > 
> > An alternative could be to keep the symbol table untouched and have
> > a separate array with symbol indexes that is sorted by their addresses,
> > but it requires evaluation if the additional memory usage is worth it.

I've implemented this approach. As a bonus, sorting during module
loading is actually faster, since only the indexes need to be moved
instead of entire symbol table entries.

To get a rough estimate of the additional memory usage, I ran the
following command on my system:

awk 'NF == 4 && ($2 == "T" || $2 == "t")' /proc/kallsyms | wc -l

It reports 83593 symbols, which would correspond to roughly 326kB
of additional memory for 32-bit indexes across all loaded modules.

For comparison, the total size of loaded modules on this system is:

lsmod | awk 'NR > 1 { sum += $2 } END { printf "%.2f MB\n", sum / 1024 / 1024 }'
49.74 MB

Thus, the additional index would account for roughly 0.64% of the
total memory occupied by modules.

> I personally prefer not to over-engineer for cases that may never occur.
> That said, your concerns about edge cases, consistency, and livepatch 
> handling are valid.
> 
> Let me take some time to think this through and experiment with possible
> solutions that handle these cases properly. I can’t work on this
> immediately, but I’ll get back to it.

I'll post v3 shortly. 

Regards
Stanislaw
