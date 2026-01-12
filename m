Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9272E7BB6;
	Mon, 12 Jan 2026 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230015; cv=none; b=Z5hEeZga+ZYfQFBd6SPLv7e3A+acvSPKRYdXxsVPE6m5feUKE+if1Qn67av8bOpDONDQSjN0ASCn3FR54c7zu9Cik+sqIoiORioCs4SZZK/lzGNDpiZkvp0R3zf62Bfhn38zI/fsygul4xwCzMf/dgZZ0UxLRcpwlj0wQvdIcNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230015; c=relaxed/simple;
	bh=n3OmhokaXcnbKVPaNRZjRHznxsmdjil5NMb6DYOcl0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+0W7PCgORqvZP6XZBIqrHOE+x8bBM/ptXG9La4f59MI0R4sGlvawBIQthSuxYAhhZepofYdjk/Up6L6+mA63a0KdQ8KNF4a7qURsyL7ekjVH2OEOazwW086vsEhWZyuVr/voYSTqnxlSqsLRO4W1rpaptPJw+MeS9Rd5q3UJM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id C973A58EC5;
	Mon, 12 Jan 2026 15:00:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 4DBC518;
	Mon, 12 Jan 2026 15:00:04 +0000 (UTC)
Date: Mon, 12 Jan 2026 10:00:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, Ard Biesheuvel
 <ardb@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add Rust files to STATIC BRANCH/CALL and
 TRACING
Message-ID: <20260112100006.7db6d31d@gandalf.local.home>
In-Reply-To: <CANiq72nV0Z_UjdAwT=41TjjfmKnT6WL4hVNcxg_QCe7TAEYK_Q@mail.gmail.com>
References: <20260107-jump-label-rust-maintainers-v1-1-702b03482f2e@google.com>
	<CANiq72nV0Z_UjdAwT=41TjjfmKnT6WL4hVNcxg_QCe7TAEYK_Q@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4DBC518
X-Stat-Signature: jb1e3yf7kkrpgpbip3bmfuu3kfwtgijh
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19XOgIFERO/UOUCL6mEFtsjAuJQxe8NDlo=
X-HE-Tag: 1768230004-959698
X-HE-Meta: U2FsdGVkX18EurLyHhKuKMPSKkWqTYSfOcdD2VG4amLAWGGwwH/Jkxh0e0sycHwYnlTL8VWJvQ9/NMXUE6ANVPe9J5W12hFtuOk8qhtvsg70rjBUI0uLQsCDfG+jICkQI0JsC4L30NJqQuTAQQLez967ad+es9O6pSHFj48OY5mJwCInMPey5hB2q+4iuG8vZ4vk+Rervbkw3Pl5g3NewAa/S7xGnYWaskrBPHA5KCAq2YPLmx31JQe/FYCh7nX/jZnjtNZ1p4nJqTI6UOejdD+ndhRBgm3HywAx9sxnx1fZ1eUBqVKztYk5sGBoatxyk5vUPhTJ14AUZD0CXVUvJBgIg6Q4quXCDAJc/OVCdfLqD7+0hFp1GA6aMBEv7nif3yKFiB6lJXk=

On Sun, 11 Jan 2026 19:36:29 +0100
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Wed, Jan 7, 2026 at 1:32=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> =
wrote:
> >
> > I'm proposing to include them under the existing entries, as that seems
> > like the most obvious place to include them. However, there are multiple
> > ways to do this. If you prefer to have them elsewhere, I would also be
> > happy to create a new entry with me as maintaining them, or I'm also
> > willing to be listed as R: under the entry. Regardless of how we list
> > them in MAINTAINERS, I will be around if anything comes up. Let me know
> > what you all prefer. =20
>=20
> I think this was meant to go after the `---`?
>=20
> Whatever Steven et al. are happy with, this looks fine, thanks!
>=20
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
>=20

I guess the question is are those with expertise on the list of people to
Cc?

I think it may be better to have a separate section for RUST so that the
rust maintainers can be included in the M: part too. Perhaps:

STATIC BRANCH/CALL (RUST)

  and

TRACING (RUST)

And have the M of the other sections be R here?

-- Steve
