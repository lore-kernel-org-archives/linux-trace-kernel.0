Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837C71AB6DE;
	Thu, 19 Jun 2025 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341637; cv=none; b=g1zpjEgIvW7QLhkSbCcbL1Pf+C6UkRaSHODQnMQV3hgxOnAzu2SR1T1IhQFScEGUqChvnj+aYf270LzAKRW4QphNqhMq20LtqTzvQTT+IJcjUsdZZX1oiDteBbFC2xoSo8d1nxcl7ejAhM6Y01cIUyPVEcmo2JSu5flkVhMHcqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341637; c=relaxed/simple;
	bh=2PU/TFSfF5yoquv02MsPO5iH70uAsHaoDtqzH+QBcPc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MHx0vH3zdqoLBQ7MPyRJlIN8c6QtqKYOYfnbjI3OeZfY0A7nxgwTqggpA3ZLfrhEzqzLhC+DiTsGZKuNhID/b28r/dettdyKxZwAyZFqG/GTNSGfkQP45xIj6V6QwAJEbIYRI2z3x7aPCKXWUUYtM40eDTkPSwmftRzvW4P4+f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id A7CE6120186;
	Thu, 19 Jun 2025 14:00:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id A4B7E45;
	Thu, 19 Jun 2025 14:00:29 +0000 (UTC)
Date: Thu, 19 Jun 2025 10:00:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, open list
 <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, Stephen
 Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Dan
 Carpenter <dan.carpenter@linaro.org>, Anders Roxell
 <anders.roxell@linaro.org>
Subject: Re: next-20250605: Test regression: qemu-x86_64-compat mode ltp
 tracing Oops int3 kernel panic
Message-ID: <20250619100028.7ec6e40b@batman.local.home>
In-Reply-To: <20250618084022.db09168befebc193c5b13a6f@kernel.org>
References: <CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com>
	<20250609220934.2c3ed98ba8c624fc7cb45172@kernel.org>
	<CA+G9fYsoCc3DnNGoavFiBdymVpdJiEfUSEq967GgThVQW7bTPA@mail.gmail.com>
	<20250610105337.68df01f4@gandalf.local.home>
	<CA+G9fYv+1FPMD8e1ZadA3nLcfSRDAWvPRW-A3bGrV0y1VP2zLQ@mail.gmail.com>
	<20250613172753.3479f786d40c29ec7b51df0a@kernel.org>
	<20250616163659.d372cf60ee0c476168cd448e@kernel.org>
	<20250617194159.d74b9cde9268ee8ace8e9018@kernel.org>
	<20250617102951.4e8d936f@gandalf.local.home>
	<20250618084022.db09168befebc193c5b13a6f@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: csrodhr8n6hxyn5kcpoefu8cfbnk9m9r
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: A4B7E45
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19FWmgWa6nPD37HBGL7vMwvnR2O60Je3yc=
X-HE-Tag: 1750341629-533940
X-HE-Meta: U2FsdGVkX1+GCj1/Wzj5MRBXDM66vhzEL5bIY5ccwbSxURTRCBxEZqThbWGOwOUk3U8NBDUFUzUYLFzpwSmfAJozfmsDRUUCt0m1EfaI4U9t9/1dQfMXZs2GKJMtiQP5KwYBOJgu6KWsPjbSbR7BCyfkH0uPgWPCBIOyXPxGRH08kSz6MMMTLiAKInDpUveaO5khN8VDqrLrJc669LZ6dChccgl8wbeWgGOjpaLSLYP8fAJLeM6zr+ydaPhVaYZcyf5+WW9ux2a8sT5zB8e0MAkoq69MZvdzF6VLDxV9Idqd6iiDnZ3svrIYA2jBhG5nXgckaaVDxu58k+ATAY3a1NP0JxyeXjME

On Wed, 18 Jun 2025 08:40:22 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:


> > I would add more of what you found above in the change log. And the issue
> > that was triggered I don't think was because of a buffer overflow. It was
> > because an entry was added to the text_poke_array out of order causing the
> > bsearch to fail.  
> 
> There are two patterns of bugs I saw, one is "Oops: int3" and another is
> "#PF in smp_text_poke_batch_finish (or smp_text_poke_int3_handler)".
> The latter comes from buffer overflow.
> 
> -----
> [  164.164215] BUG: unable to handle page fault for address: ffffffff32c00000
> [  164.166999] #PF: supervisor read access in kernel mode
> [  164.169096] #PF: error_code(0x0000) - not-present page
> [  164.171143] PGD 8364b067 P4D 8364b067 PUD 0 
> [  164.172954] Oops: Oops: 0000 [#1] SMP PTI
> [  164.174581] CPU: 4 UID: 0 PID: 2702 Comm: sh Tainted: G        W           6.15.0-next-20250606-00002-g75b4e49588c2 #239 PREEMPT(voluntary) 
> [  164.179193] Tainted: [W]=WARN
> [  164.180926] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  164.184696] RIP: 0010:smp_text_poke_batch_finish+0xb9/0x400
> [  164.186873] Code: e4 4c 8d 6d c2 85 c9 74 39 48 63 03 b9 01 00 00 00 4c 89 ea 41 83 c4 01 48 c7 c7 d0 f7 f7 b2 48 83 c3 10 48 8d b0 00 00 c0 b2 <0f> b6 80 00 00 c0 b2 88 43 ff e8 68 e3 ff ff 44 3b 25 d1 29 5f 02
> -----
> 
> This is because smp_text_poke_single() overwrites the
> text_poke_array.vec[TEXT_POKE_ARRAY_MAX], which is nr_entries (and
> the variables next to text_poke_array.)

Interesting. It must be that the stress test was able to get in and add
a bunch of individual entries while a batch was being performed.

Still, both are a bug and solved by the same solution ;-)

(Two for the price of one!)

-- Steve
