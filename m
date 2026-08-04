Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9425C3FBEA5;
	Tue,  4 Aug 2026 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873068; cv=none; b=A6vMQMPgJ0tSYj7rv7Yqszbjk28iYTzVLVRyoYE8LC9MDAfCqmRqjPHWqKt8yl5RPSbJFb17WW67MWGhIqo6d0b9sv9KJ51BGxMa84Ga7cVNcnOGZxtDeJNsogHjDQeb1swX3xT/5vFvYi+1Zx7VsQgaHjNWTDzBHJTLlYhMOy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873068; c=relaxed/simple;
	bh=xCOtBiRirVhk9N5O7uIXpP8tkgsD5NMKOPFf8TOX6BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtKW5EXewjRi9NJoDyuYve30bfN64wsol6oEqKXu/ukDduAVeH7khmdhPp3YdrOaQESWj7RZa1fB8j4nFvsfNiOZ6DJJeSmbvAEvMiZTqUWlLdlQ0A/Ryvf/tQCULI898bu4kN9lLbKxYDUv/JZEw1bfYyAW/Q7V/wTJP1Oo5/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from martin by akranes.kaiser.cx with local (Exim 4.98.2)
	(envelope-from <martin@akranes.kaiser.cx>)
	id 1wrLAD-00000000HDr-3OL0;
	Tue, 04 Aug 2026 21:51:01 +0200
Date: Tue, 4 Aug 2026 21:51:01 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, oe-lkp@lists.linux.dev,
	lkp@intel.com, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] selftests/ftrace: allow relative paths in eprobe test
Message-ID: <anJCpUP4sGnggyOY@akranes.kaiser.cx>
References: <20260721200612.1749777-1-martin@kaiser.cx>
 <20260723092654.12f7be2910e3e16259c61125@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723092654.12f7be2910e3e16259c61125@kernel.org>
Sender: "Martin Kaiser,,," <martin@akranes.kaiser.cx>

Thus wrote Masami Hiramatsu (mhiramat@kernel.org):

> On Tue, 21 Jul 2026 22:05:59 +0200
> Martin Kaiser <martin@kaiser.cx> wrote:

> > The add/remove eprobe test installs an eprobe for the openat syscall,
> > runs ls and checks the filenames that were opened.

> > Commit 206b25c09080 ("tracing: eprobe: read the complete FILTER_PTR_STRING
> > pointer") fixed access to some string fields in eprobes. This allows for
> > dereferencing more filenames. In some cases, the log now shows a file
> > with a relative path instead of "(fault)". A relative path makes the
> > test fail.

> > Relax the filename checks to fix the test. Allow shared libraries and
> > locale configs that use a relative path.

> Hmm, should we check this "nocontent" ? This change seems a bit fragile.
> I think we should use another syscall to make sure getting filename
> correctly. At least this point, removing nocontent check will be better.

I've just sent another patch that uses chdir instead of openat. For chdir, we
know which filename we'll see in the logs and we can use a simpler filter.

Best regards,
Martin
