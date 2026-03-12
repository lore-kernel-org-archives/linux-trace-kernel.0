Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FDF282F0D;
	Thu, 12 Mar 2026 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334820; cv=none; b=DQQtmKnSqa1LIkJbK2Iveb/XSgl+vKWM2uVJUyr0Pe02JEsz3FfFX8Y0pbGTsHmd6aLgvcfPrY8rRqQW/RaAV+cn7Fw6RbyaLpklBnLzBlLDL2xu7pa4za+P7769GId73CvqXeFkedfCcAokJn88WN9Tq/xH5i+M/m0Wn4K9oRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334820; c=relaxed/simple;
	bh=Vgn6UpaYUBx0O2rnYX40EpaPbW7xAEdaZewfD1mbCGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpD38U8miEk1B8+wvMY5rdCIdiSqLzJ1eiCKRJPRbVQH9Hfl2qFlpEa/iKoReF+NQx+P92LTiYYnbYMjEoswvVcwZkj5v2YpDe2Oy5cZg0eCI/+dwOqqdRdVplODgvCUr5ZbE+XI7Aiqqpj6x8SZTEJFqt4jdMJGtaUbbH6ng+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 352DC1B7777;
	Thu, 12 Mar 2026 17:00:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id F3C7020029;
	Thu, 12 Mar 2026 17:00:07 +0000 (UTC)
Date: Thu, 12 Mar 2026 13:00:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Brown <broonie@kernel.org>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>, Peter Zijlstra
 <peterz@infradead.org>, Michael Hennerich <michael.hennerich@analog.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 13/15] spi: Use trace_invoke_##name() at guarded
 tracepoint call sites
Message-ID: <20260312130022.669e7de4@gandalf.local.home>
In-Reply-To: <06438818-2e3e-426f-aec5-ea6344e4b057@sirena.org.uk>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
	<20260312150523.2054552-14-vineeth@bitbyteword.org>
	<5d057b07-be5a-4da6-86e3-87ef4319d4b2@sirena.org.uk>
	<20260312114254.6467c03d@gandalf.local.home>
	<06438818-2e3e-426f-aec5-ea6344e4b057@sirena.org.uk>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: F3C7020029
X-Stat-Signature: gf9obfxre5ffay4dshebqzgsu9ekx3eu
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+g4lotslKuMjUGVYGeqaMsb2wFNEgD1mg=
X-HE-Tag: 1773334807-77202
X-HE-Meta: U2FsdGVkX1+EgPwuZ/3LJe+ZWj5snkoHf4Ns5V3n/QOffJxeZenIlzT0xPZ7RqOfNTBmja4mlyx7155oniBVQtSKsWVO2bDNd6puqYKJDeUMq03+B1VW5w42DmEHc4EOutoxhVYKBJb+bnJIgZmKzLshMKt9/U98CvDwGRcrRKKlXsGKLkKNQfu9aMCz0KPuzdlY9WvPpxpL1TPipnTcTMRI1DVC+ZPuGG4w+rp8eiCRXNKCxebLg6sahVWitctxNtIaGqVKoWt8SLqpExQN9BNbAceUxAlpLSDialptoxebHiezYZybpNRm0e1kHC61+WZsE2LMll/3qbY0Z3Dj/I5QgNvIZre2omPTqyIk+YpTd1IuNP1fig==

On Thu, 12 Mar 2026 16:54:00 +0000
Mark Brown <broonie@kernel.org> wrote:

> Possibly an _unchecked or something?  Honestly the suggestion someone
> had for _do seemed OK to me.  Part of it is that I wouldn't think of
> tracepoints as being something that I'd call.

The "__do_trace.." is an internal function I don't want to expose.

I'm thinking of: call_trace_foo(), as that should be pretty obvious to what
it is.

I want to avoid the do_trace_foo() because that's usually the name of the
wrapper code that is done in header files. Where the header calls:

 do_trace_foo()

and the C file has:

void do_trace_foo(..)
{
	trace_foo(..);
}

Which could be:

void do_trace_foo(..)
{
	call_trace(..);
}

And remove the static branch there.

-- Steve
