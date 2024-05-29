Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03FA42069;
	Wed, 29 May 2024 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998507; cv=none; b=e61DfiiPENmVfqk6EbDeCgixYV78xKdpKpNp+H6BUdHmUnkSrZYEhdK6KX/jqPxvEGQrS5pXoN2NL094rXlB52RJyFcglto5VNUN1amxVcOxuCvH+OmtytNdmvFg0sIprbHJrEaVpvTSamxR1kSD8SWUfD8JamwjMvgJ+FTIbZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998507; c=relaxed/simple;
	bh=B0tHJXr521Nz5ptgu8zXMxt0ClW1L6gfaaq+puzVGvM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NxwfuSbGm1Dh0KTEvTWetBY1ZNs+Pqqgh6dmg3eJ716YkZLJGqBMh8uCWhys6yGvN/AgzmlUBwoW+KiEJLmMpcfmhJJa40GDveM8Kkn57yKonNc65GNIUCYzrmpc2BM6BKLSyiiadkVeYL0T9hnEg8T6XKEmgXSk2avjkwZiXmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kwDMf22p; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kwDMf22p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716998506; x=1748534506;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=B0tHJXr521Nz5ptgu8zXMxt0ClW1L6gfaaq+puzVGvM=;
  b=kwDMf22pWMxTrhB7WkQDVgE2M45cObhef+27rRR7/en0zZLoQxAD6cTH
   ThfhS8jDkDsS+Fm5GWBoFQ4IZYvtaZic8VS80SvDmiIWBhUJE1PK3g69y
   5J/iMU7XJzDf6BzQXDuZXhlf+uJCKGWgyVUgVBx3ywNQ+4s2UQQdVugFI
   R6vTXfp2qLHUbGqL5O2BmpcH3eY3CoUX0bxbHhWPBXz5z4GzVaftkI1W/
   StpQcAQJH7LFboPxBDFgRPtj7fMJ8XHhroDCAt10dJIHmLoNfe2DiuaLF
   ZJipWSJqlmUZ28/tNx018u4dw+H8BKJ9WAnUBo6SRIxy0Qnyc03J6B2vS
   A==;
X-CSE-ConnectionGUID: +so+T2vcSpKmshgJXo1iPg==
X-CSE-MsgGUID: 9JgoOJD6Tdu13dDWuiqW5g==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13595386"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="13595386"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 09:01:45 -0700
X-CSE-ConnectionGUID: ZNxxFe1dT3GWUsmX+Tvi0g==
X-CSE-MsgGUID: E8vuwEGmSLOGZthWHfIPhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="40339011"
Received: from mdutta1-mobl1.amr.corp.intel.com ([10.213.167.110])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 09:01:44 -0700
Message-ID: <3a7e679712fb47b6c75af84163b5d3ea252f4da9.camel@linux.intel.com>
Subject: Re: [PATCH 0/3] tracing: Fix some selftest issues
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,  Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Date: Wed, 29 May 2024 11:01:43 -0500
In-Reply-To: <20240529083818.b7835de167191d4567405ce6@kernel.org>
References: <171671825710.39694.6859036369216249956.stgit@devnote2>
	 <20240527192907.49c9220f@rorschach.local.home>
	 <20240529014640.3a04f7301f12eb44738f9f2d@kernel.org>
	 <20240529083818.b7835de167191d4567405ce6@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Masami,

On Wed, 2024-05-29 at 08:38 +0900, Masami Hiramatsu wrote:
> On Wed, 29 May 2024 01:46:40 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>=20
> > On Mon, 27 May 2024 19:29:07 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >=20
> > > On Sun, 26 May 2024 19:10:57 +0900
> > > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > >=20
> > > > Hi,
> > > >=20
> > > > Here is a series of some fixes/improvements for the test
> > > > modules and boot
> > > > time selftest of kprobe events. I found a WARNING message with
> > > > some boot=20
> > > > time selftest configuration, which came from the combination of
> > > > embedded
> > > > kprobe generate API tests module and ftrace boot-time selftest.
> > > > So the main
> > > > problem is that the test module should not be built-in. But I
> > > > also think
> > > > this WARNING message is useless (because there are warning
> > > > messages already)
> > > > and the cleanup code is redundant. This series fixes those
> > > > issues.
> > >=20
> > > Note, when I enable trace tests as builtin instead of modules, I
> > > just
> > > disable the bootup self tests when it detects this. This helps
> > > with
> > > doing tests via config options than having to add user space code
> > > that
> > > loads modules.
> > >=20
> > > Could you do something similar?
> >=20
> > OK, in that case, I would like to move the test cleanup code in
> > module_exit function into the end of module_init function.=20
> > It looks there is no reason to split those into 2 parts.
>=20
> Wait, I would like to hear Tom's opinion. I found following usage
> comments
> in the code.
>=20
> =C2=A0* Following that are a few examples using the created events to tes=
t
> =C2=A0* various ways of tracing a synthetic event.
> =C2=A0*
> =C2=A0* To test, select CONFIG_SYNTH_EVENT_GEN_TEST and build the module.
> =C2=A0* Then:
> =C2=A0*
> =C2=A0* # insmod kernel/trace/synth_event_gen_test.ko
> =C2=A0* # cat /sys/kernel/tracing/trace
> =C2=A0*
> =C2=A0* You should see several events in the trace buffer -
> =C2=A0* "create_synth_test", "empty_synth_test", and several instances of
> =C2=A0* "gen_synth_test".
> =C2=A0*
> =C2=A0* To remove the events, remove the module:
> =C2=A0*
> =C2=A0* # rmmod synth_event_gen_test
>=20
> Tom, is that intended behavior ? and are you expected to reuse these
> events outside of the module? e.g. load the test module and run some
> test script in user space which uses those events?
>=20

Yeah, this module was meant as a sample module showing how to create
and generate synthetic events in-kernel.

So the interested user insmods the module, looks at the trace stream
and sees, ok the events are there as expected, so it does work, great,
let's remove the module to get rid of them and go write our own.

Having both the creation and cleanup in module_init() wouldn't allow
the user the opportunity to do that i.e. verify the results by reading
the trace file.

Tom=20

> As far as I can see, those tests are not intended to be embedded in
> the
> kernel because those are expected to be removed.
>=20
> Thank you,
>=20
> >=20
> > Thank you,
> >=20
> > >=20
> > > -- Steve
> > >=20
> > >=20
> > > >=20
> > > > Thank you,
> > > >=20
> > > > ---
> > > >=20
> > > > Masami Hiramatsu (Google) (3):
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracing: Build event generation test=
s only as modules
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracing/kprobe: Remove unneeded WARN=
_ON_ONCE() in
> > > > selftests
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracing/kprobe: Remove cleanup code =
unrelated to selftest
> > > >=20
> >=20
> >=20
> > --=20
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
>=20

