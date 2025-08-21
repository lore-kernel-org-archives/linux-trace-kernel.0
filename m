Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F1B26F2B2;
	Thu, 21 Aug 2025 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778934; cv=none; b=oQ8TMRJSopddw+u3vCrGXdzw1PLXMIYKmutnWaQ6qAZhMjaStnqTxK3lW8fZa8xR/aJ0uMg+LtjfsLidSDZq6lzxjQdtTFETIwZvmjSA0DS6Yd10dB17s3f9sa30kXagBknpe+Xn8EqqRLTqS9XXItOzonLR7nZ5h4dEhrYw+dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778934; c=relaxed/simple;
	bh=lBEjdKy9yQabFSqInWTXFRzH25uJEOMHVsj3xj5Oj4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXVwg2kPg+uVW5qxqQXWaszna5dP3TGZ9MAbbWLN+eBg5EDEB3wXfQP3fSwQVpTeCDeEbQfGByirlEt7vNbnS4tf3CUvxjkATt2AAEVbQgRdmuokLDgmlPEFSki0iK9cgLIfLDG5AA4imfqYTcKBMhOBncnjZEGnYz+CSdBpJkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y5CTjjVr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kHqscCRc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y5CTjjVr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kHqscCRc"
Date: Thu, 21 Aug 2025 14:22:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755778931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vw4cKZs259ZSqnWcEQVQVDScYmUQQCML6GAeQxTOIKs=;
	b=Y5CTjjVrwvOyHlLAxxUH5VFDLTAp1hM16t9yjzoaUcSws15QugCYviGihNy5O5sO1qYnje
	26s9vzreSHdBGT+bX70BVV57rw+lx0BTZl7mrVS5utS12klpyFe3UOpUTzRhPU99jfSw8e
	3hugEX20HJDcI8LTshm1KdvM6ZWxyENaiJnQT3jZZajKRzvFYH6K9DCoRqQTrnvydWm6Ta
	elPW7dJO+QWnqI+exMPHZyw2ZwkT8gv05Jln28bVgDhIyUui7ceyFTC0WgsZSboIj8F297
	Old5DcELUVdU3qTdhmB/klWG1qsEE5moqY46r8H57Uo/J5XOts1BzF69xmS8Tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755778931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vw4cKZs259ZSqnWcEQVQVDScYmUQQCML6GAeQxTOIKs=;
	b=kHqscCRcWCnMA6HAZ+LK7nJVWR0KNnYcZttZC/7Gwf3o99yR4rbsl4HWGdydpod9hwdm5l
	unwuytZAHbx+s7Dg==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 09/17] verification/rvgen: Allow spaces in and events
 strings
Message-ID: <20250821122210.B9iAsUFG@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-10-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814150809.140739-10-gmonaco@redhat.com>

On Thu, Aug 14, 2025 at 05:08:01PM +0200, Gabriele Monaco wrote:
> Currently the automata parser assumes event strings don't have any
> space, this stands true for event names, but can be a wrong assumption
> if we want to store other information in the event strings (e.g.
> constraints for hybrid automata).
> 
> Adapt the parser logic to allow spaces in the event strings.

The current parser does have a few problems. Not all valid .dot files are
accepted.

I have a patch buried somewhere which removes the custom parser and instead
uses a library. But then it adds a new dependency, so I'm not sure if it is
worth..

Nam
