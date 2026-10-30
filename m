Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793321558;
	b=Zl0zlkRCSSVlRPJ88eBjZ96ULABbGAkhJy+29vqP4e7rFOVb+CHpT+bc49AvNaOBgJXG
	 n1rnVMeMB/4lpFzLEa9HfZYV882fm6ECtYHkqWNwWUDyFTmZpSAA8JhlRlSq/rzMxg17V
	 c3+coc6NhHq9satHlv6S756oFzkpjldhJBeOZjNRZI5cP/r1LxBHPx8oH1Ar1MInsMd/y
	 qm4Jd7wl39J94nSvoRiDt7OYsdghvu0f2DxcykYiVGnrD+qnjpHjyyQJZINsrXC/dQ+IY
	 QdX9zpcJRyWSvo5zRCiLl+7ONCxsX1P62PIoeEK87j1biuI/ZfKRXIXHu8UByJGtfIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793321558;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Bja33s15MZyZ17YPDDTlUGRX30Uc8070ILFU7o0PzUs=;
	b=W3VldQ2mHkVxMYfuTItXvs7fXmf+tjObDlLF7FJyV9Jlx3wTviHkQCFu601WDvFn7TSH
	 IKSMmARMNZiI5GC88PPG4RTVi4D45FDoisWBs2Z+eLXHj9TIHOnYyyFDdO+Yw+tTiC31i
	 IPOQpwTQpE6iJf8bnfDenJS9RVLMz3Smvn8evqadERA/pYUmuVZ0aJHv0MeZ55mUEM5QH
	 /b6ap5hugVejJAL2gnvEyvrwOnTYK+yPqbGdI7JmnJy21fUBNwmJ44ULaa4sIX4BqDu89
	 BQ8ghibyuPTZSRhA6Ms4O5EpTUSudehzRUM9T+sYOX8eV+5WHs3Kxzsq87rKXCypvWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NTknd4Qf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C92606A31A;
	Fri, 30 Oct 2026 00:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NTknd4Qf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EF21F000C1;
	Fri, 30 Oct 2026 00:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793321558;
	bh=Bja33s15MZyZ17YPDDTlUGRX30Uc8070ILFU7o0PzUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NTknd4QfPPGmxcFOHDwmKHAWsy+x4oORmbRz7vsqongVyxRdSeJB5gutZnc8zQmUW
	 n1SHCYaczeknB3wrTzeM/OwqxBT7yx7wllAUBhD4PqVzsiaPTUys19O+aKWJKIj6fl
	 /0FASaYSkUqpbOD0LIcnreCO2eFktd2+4IQ6gL9p5lxlXD/WDHrf3CqNlYhKIAhk4i
	 919ORd5TQnX84gbge35WX4mWwoaX2ml8+4TAtO2b75iB1Yjm7msbJSbBvU8mtucFwk
	 DurL/x5Esu1v5nNVk/fTqkudieA/+uzFHx8aYue9t86fK9JXWhP0utYILsme5ClUKI
	 pFrQldK9n7N8A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, linux-trace-kernel@vger.kernel.org, oliver.sang@intel.com
Subject: Re: [PATCH] selftests/tracing: Fix flakiness in trigger-hist-poll.tc by waiting for task exit
Date: Fri, 30 Oct 2026 09:52:34 +0900
Message-ID: <undine-1793321554749991836-eb67f28b1c374d03@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261029163452.00d0980c@gandalf.local.home>
References: <178459323652.354837.10711230683477156733.stgit@devnote2> <20261029163452.00d0980c@gandalf.local.home>
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
Content-Transfer-Encoding: 8bit

On Thu, 29 Oct 2026 16:34:52 -0400, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 21 Jul 2026 09:20:36 +0900
> 
> I'm finally getting around to looking at this!
> 
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc
> > index 04eb8546fc07..d54d54f9ec77 100644
> > --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc
> > @@ -38,11 +38,7 @@ BGPID=$!
> >  ${POLL} -I -t 4000 ${EVENT}/hist
> >  echo 0 > tracing_on
> >  
> > -if [ -d /proc/${BGPID} ]; then
> > -  echo "poll exits too soon"
> > -  kill -KILL ${BGPID} ||:
> > -  exit_fail
> > -fi
> > +wait ${BGPID} 2>/dev/null ||:
> >  
> >  if ! grep -qw "sleep" trace; then
> >    echo "poll exits before event happens"
> > @@ -60,11 +56,7 @@ BGPID=$!
> >  ${POLL} -P -t 4000 ${EVENT}/hist
> >  echo 0 > tracing_on
> >  
> > -if [ -d /proc/${BGPID} ]; then
> > -  echo "poll exits too soon"
> > -  kill -KILL ${BGPID} ||:
> > -  exit_fail
> > -fi
> > +wait ${BGPID} 2>/dev/null ||:
> >  
> >  if ! grep -qw "sleep" trace; then
> >    echo "poll exits before event happens"
> > @@ -72,3 +64,5 @@ if ! grep -qw "sleep" trace; then
> >  fi
> >  
> >  exit_pass
> > +
> > +
> 
> Hmm, any reason for the two added newlines here?

Oops, no reason. Maybe typo on the editor...

Thanks,

> 
> -- Steve
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
