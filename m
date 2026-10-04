Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D9A2BE034;
	Sun,  4 Oct 2026 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791104960; cv=none; b=MblgMMLSuEvMHaL2gC1xRr59QFW27C4kFi1lmnmYmODI58No0JIDGWmlnaL4etN9lbjmpbXRSuRQh/nqsH5ptFtjgldnfrY27Ov+g2NvuFzbcJnCXxIVD7eeIPaGrNhMbKBdjdNDsQh8P/jdvxaB5AJko6tfw0z/QzzGpTa8uUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791104960; c=relaxed/simple;
	bh=m3+Muw9xdsKZTlVAFncABHSx/jWeDBFS8lhuxCl+VSI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/F1mL6yAYQdwn2p9ffWeLN7dnM9RTm4D7ELvS+sKOPhnGRck2m3teT0wtQf8GOve2gll5D9XABYpQYw0xnLCcarJ3t/07y2mE/fBv+R77i20osBJArLPA4V6rGLQo+Vr4S+tYB14nT6IP6a2Fvh/B8CU/G9ZHzz4qayGCFdF10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=FQ4B7c38; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="FQ4B7c38"
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 7F7FF1C3EFC;
	Sun,  4 Oct 2026 09:09:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 04A4D2F;
	Sun,  4 Oct 2026 09:09:10 +0000 (UTC)
Date: Sun, 4 Oct 2026 05:09:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Lawrence Lin via B4 Relay <devnull+deduce.gmail.com@kernel.org>
Cc: deduce@gmail.com, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Petr Pavlu <petr.pavlu@suse.com>, linux-modules@vger.kernel.org, Stanislaw
 Gruszka <stf_xl@wp.pl>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Avoid quadratic symbol lookups in
 ftrace_module_enable()
Message-ID: <20261004050904.06a5ecab@fedora>
In-Reply-To: <20261003-ftrace-mod-bsearch-v1-1-92e2fd2d80ff@gmail.com>
References: <20261003-ftrace-mod-bsearch-v1-1-92e2fd2d80ff@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 04A4D2F
X-Stat-Signature: m81cmqzreg8pfymuirdqsgoyryw8zqcz
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+VFOVb5c40zQRx0NDKTb8yjxVareGzTFI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=bvNjCPW87QjBuKCrWM9oVuVOnsojI94Ko33jmK4OTFI=; b=FQ4B7c38H3XrdRsSHhYUUWdbqbBTZz3W6qFvEEJPMshrhzhqFltofiv2OS9n8oQyADs4dF2SVZx9Qg+e8egWuZ34p+W9mP4uFZ02KWtFA8Zs4rCF7qQa3LcHZo6Ptbt4TfXVfOql/fKy59WyPcNiHqzl51Aikotucr5spcomrq4=
X-HE-Tag: 1791104950-341484
X-HE-Meta: U2FsdGVkX19qD9uqcO2x5VYtOa5WEvoyCKTSfcCZWJ7rv0aMW5eK9mw3LOSfh9evpSPFBWS/zo+m7yramWDNSYyYMS/JMePwmm0clOKPMcklhNvd3o/RwA8DgkXtW52WCsyvvcS2RitLAUM4sXyPBqYHCMPcTNW6Td+0vd830AOKpnQckxSNN5jemqo3o3ixwNWuYLJNen0PTbr2XkZDBFsAmCGnGF2qiwwhIMy1rBXKIq/KZo8tHpc5gIdfadrUANCkxSstzaD6+ew0wIoJvLp6EjtaTR6Sy6/EoHaLG+yOBL/ix0mX8JYk37FDEA8uOkwIrsMtckKS2Yt+LNAzLnKVeXd9JvjDJO5zIrdDqvBf23mRgU3U4Q==

On Sat, 03 Oct 2026 11:27:10 -0500
Lawrence Lin via B4 Relay <devnull+deduce.gmail.com@kernel.org> wrote:

> From: Lawrence Lin <deduce@gmail.com>
> 
> Since commit b39181f7c690 ("ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid
> adding weak function"), ftrace_module_enable() calls test_for_valid_rec()
> for every ftrace record of a module being loaded. test_for_valid_rec()
> resolves the record address with kallsyms_lookup(), and for a module
> address find_kallsyms_symbol() scans the whole symbol table of the module.
> Loading a module therefore costs O(records * symbols), all of it under
> ftrace_lock.

Honestly, I think we can revert commit b39181f7c690.

Since commit ef378c3b823385 ("scripts/sorttable: Zero out weak
functions in mcount_loc table"), I believe that commit has become
obsolete. I just kept it because I didn't want to add regressions.

It would be interesting if it actually triggers (finds something). If
it doesn't, then I think we should just remove that code instead of
adding more complexity to it.

-- Steve
