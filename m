Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AFF3191BD;
	Fri, 20 Feb 2026 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771607542; cv=none; b=itrZ9Ivs6xmZvcMId+a+ZDbA+axnqHph9Vm25iN0h9EGL8XcE8mDWgTxXn8nN4eDG5gJXDXdEi74rbRW7Jf6/UXuQj9nchVAPNsfSevjt552KnbKrYBjXmhyfuuoK0AYVaZU36VY4VIutzel/8iy10HcnbbkgcdaYUBnRR1QOnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771607542; c=relaxed/simple;
	bh=zF9v6DhVvXH6Ke/b2ZcPk8ZQPBgh1eOGp+zFfLufSyE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kb+TEjcdO/WWvSaIYuu3o2wcniJ9Sr/Pp54jIHJoqPkFHqX/pYPtA9hVHZq/JHxwp62D1rHQXnhNbnfd0i6uuTjM4koglSek5A3ms8bov6AM7nj3hzL8YfSqxBkZ6Ra+4fEn5NMUif7NbAZ9wTu0pEVHeCznN7lT72trlXyXEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 69FD3C13B9;
	Fri, 20 Feb 2026 17:12:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 3072E20011;
	Fri, 20 Feb 2026 17:12:14 +0000 (UTC)
Date: Fri, 20 Feb 2026 12:12:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <kees@kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, "Elly I. Esparza"
 <ellyesparza8@gmail.com>, linux-kernel@vger.kernel.org, luto@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, Naveen N Rao
 <naveen@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86: Prevent syscall hooking
Message-ID: <20260220121222.11510f4e@gandalf.local.home>
In-Reply-To: <aZiUJ--WJygUU6QP@infradead.org>
References: <20260218144735.24307-1-ellyesparza8@gmail.com>
	<0c5396b5-f084-4ade-adc9-029037031eea@intel.com>
	<20260218105204.3af7251e@gandalf.local.home>
	<202602191041.4CB9C4AAFD@keescook>
	<20260220114540.fbee78a9a8b8097ec729451c@kernel.org>
	<aZiUJ--WJygUU6QP@infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1nnyufhxesrkgtkem3axqnnq7rn135o1
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 3072E20011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/ncn6Um40GPy529DWUg5J+KPMH4KCp4R0=
X-HE-Tag: 1771607534-886332
X-HE-Meta: U2FsdGVkX1+sr2L2YelYOLgfSnFFE7gdfXbIwYGyPzKWq7YXvd9Eloe4wTNTKOaUV0nIux70O2FiAEiz57to3wFZyl+SrZLULCpljdEbTxS1orSUgiocLBoLK/4Cci+JX7v9PTHOwF3cw1vXfd8yeR1vUtVd/x3VSf4VyHE9rEoiEMhuP9ohknF+c98QjLN0ZSZQxLc8Ew7aMwkcCPR6bFAx/xpFG/j+C5bfCjxVUHLvA9jNC22DdFPIE3KnWFljFCgE4P9cR9hAsGoCOm+daqrQPH1BEH5+tnkUJq5gDVPlwXSklmUGApM1w201KYDC01rxaaIipqBT3aQcbSmq9VCHfBFOfihUQYIhBYwFLeW5ENKcWyHEGZLbVP9ia/eQyuxB1znFRpObgA02zcdnkg==

On Fri, 20 Feb 2026 09:04:39 -0800
Christoph Hellwig <hch@infradead.org> wrote:

> > Agreed. The blacklist (or blocklist) of kprobes is designed for preventing
> > nesting software breakpoint handling, not for security.  
> 
> It still can be useful.  As mention in the other thread, we just need
> to make it clear.  I.e. add something like "noprobe_for_security".
> And if we really, really care it could be conditional on a config
> option.

As I already mentioned, we have the LOCKDOWN infrastructure for that. If
you care about security of kprobes, use lockdown to disable it. As
previously stated, there's 1000 other ways kprobes can get this same
information. Adding a "noprobe_for_security" will lead to a false sense of
security. Basically the same as leaving your car unlocked and hiding the
keys in the visor and thinking nobody will steal your car.

-- Steve
