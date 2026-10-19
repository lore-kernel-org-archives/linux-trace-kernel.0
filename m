Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC654FD790;
	Mon, 19 Oct 2026 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417991; cv=none; b=D4ewbRjqHtlBhSPwxrZXs472uYkBif+p6011Av1EAm3fFhsmx2FHhYI1dnGynPftS9N+hr1U3FUNPeJHm+U2fV8aO5U8B9xfyx9dCzUzDumA/HWosSUHLBB2twGhslOPKlYUqQ72LGbkXqsj/lPyCHw5JzvQ4j1gJ8no40iO7pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417991; c=relaxed/simple;
	bh=EVyJh9ZWLHl91/FGCQEYtUVABmv7Hm3ljiwYKDp4qo0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VPBXBj5RVhmM3rvNtsryCIWjoFv6T5UHSdEbHK7i25ICq3nN6TysAiCegHKtfK6xmzqvQBXNnHf1I1YZIoZyKXbfZsGrvcmwZVN3Sqd8mIdbOkIVpFU0FbuX8fuow1Kum917Dfr0pxissK3fWNRV6vDD4JNfjAhYlV9TDACKoLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=XREVXirX; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="XREVXirX"
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id BCABCC069D;
	Mon, 19 Oct 2026 13:53:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 055E980013;
	Mon, 19 Oct 2026 13:53:03 +0000 (UTC)
Date: Mon, 19 Oct 2026 09:53:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Leizhen Zhang <lzsx618@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracepoint-update: bound section names by the section
 name table
Message-ID: <20261019095302.5a4aa377@gandalf.local.home>
In-Reply-To: <20261019000419.3977860-1-lzsx618@gmail.com>
References: <20261019000419.3977860-1-lzsx618@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: bdi6cix1tpr7f1qxpcpygreib3a8b3g1
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 055E980013
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX198AuhKCPy3rVd8IA4rXj5dGwgwlrzjZJ4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=ydiIjkJiB8cg5pLI7vUSmkF/iGkcVED4sMxBUah57vE=; b=XREVXirXD4I/qRZxvQyhZ/tC4QecDr8Wr6OHauGO3Oic2GqVUD6mOH91d/jW5JvsSKoFWCxwcaVYAvWFe3TqVPXFPuZ50XdUEniJ8RE9xPsohpZelvnVAJDWgBpO91hiaiFKtroVdF56Y703letFrXXSyuWMhuCzilMOeCENnO0=
X-HE-Tag: 1792417983-631829
X-HE-Meta: U2FsdGVkX1/RZug/ND+7JeIR18g+rnDvnIOGRHhnTKHJr5z+cofm5IAazpRMZKpa7xTXtEXEskci7reRRqI8noQ6R/gpy5Vnn1MoIUsGKPGRxN5gPSRGL5lXZ7YoiFzNf7NQjQgUBOaQqfgCFeI3OrkmfrZaPmVhcRh36WITIuLtXe0lCl9n41JpixEMJr3RbFDMHZqVmj4HGfAMYkfCOoETrAOfKU6xVAjsoZCafbIkSBos21M3r5/n7dxMTGGkkIMHLvX3ykSTdxaINPgVrOajp/238cSjtnwAogqUdw6GBuDp2rISsadOspLRrLx04sjEz7d2X7PrWA3L+O2dEkmptLCj0OsBm7/QZYf4a1PXGLC9QsCsxtooRXHS+3Ey

On Sun, 18 Oct 2026 19:04:19 -0500
Leizhen Zhang <lzsx618@gmail.com> wrote:

> process_tracepoints() finds its two sections by name:
> 
> 	secstrings = (const char *)ehdr + shdr_offset(string_sec);
> 	...
> 		idx = shdr_name(shdr);
> 		if (!strcmp(secstrings + idx, "__tracepoint_check")) {
> 
> sh_name is a 32-bit offset read from the file and nothing bounds it, so one
> section header can point the name anywhere and strcmp() reads from there.
> 
> Found by fuzzing the host ELF tools with mutated object files under
> ASan/UBSan. Reproducer, setting only sh_name of section 1 in an otherwise
> valid .o:
> 
>   $ python3 -c 'import struct
>   d = bytearray(open("tiny.o","rb").read())
>   shoff, = struct.unpack_from("<Q", d, 0x28)
>   entsize, = struct.unpack_from("<H", d, 0x3a)
>   struct.pack_into("<I", d, shoff + entsize, 0x7ffffff0)
>   open("t.o","wb").write(bytes(d))'
> 
>   $ ./tracepoint-update t.o
>   ERROR: AddressSanitizer: SEGV on unknown address 0x7f8d689ae848
>     #0 in strcmp
>     #1 in process_tracepoints scripts/tracepoint-update.c
> 
> Skip a section whose name offset is outside the name table. Such a section
> is neither __tracepoint_check nor __tracepoints_strings, so skipping it
> changes nothing for a valid object: the reproducer and an unmodified object
> now both print the same "no __tracepoint_check in file" line and exit 1.
> 
> This bounds the index into the table, not the table itself: a name table
> whose own sh_offset or sh_size is bogus is a separate gap, and in the
> elf_map() path used here there is no mapped size to check it against.
> 
> Fixes: e30f8e61e251 ("tracing: Add a tracepoint verification check at build time")

This is not a fix. This is just passing a corrupt object file into the
build tooling and showing that it fails.

Show me that this can be triggered by a legitimate object file and then I
would consider it. Otherwise, you are chasing made up bugs.

-- Steve


> Assisted-by: LLM ASan UBSan
> Signed-off-by: Leizhen Zhang <lzsx618@gmail.com>
> ---
>  scripts/tracepoint-update.c | 5 +++++
