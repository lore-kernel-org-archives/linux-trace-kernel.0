Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794499915;
	b=B6q12GVlYDfDHwDhi2iKsVAUWqE079o/IM7QACQUyLzTELGwKyCvwJ2Dt70cwweYlXZJ
	 M4Dtz8a7la77SL7WilmfdX45mI+mF77+4NMZthDiSC+Yw/vge0dD8hvQ9ju0UogMVMtOq
	 33MXoqkYVEuTOSULH6FmF2+ybUNhcTJ9zTTznPKYHHAs6G73VtnVSYkz/2/ktDeSRrYHJ
	 3sbUa2ZVz76uT+j2pgrsQDg8gxoV2IoYoZ+rqfyXm/uHKCKDZQWWZNOCabADpad72i3F1
	 rqrwU0K5JEAOMyo5xht9tOsHFz3EGFRCOA7Afa6xFiElE+bP/FBTBsXkmnO7sqx7QbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499915;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=0sScZLnu1TmY3yWO4GbI6auwI6UD8n/C/vabFRqYDbQ=;
	b=jsAn+qWcZDQqty4xl7SNFpyMV19qJ/g5XRqgEjbdQ2RclW0JJC0VXtdiECzBF7fgFUvl
	 X15p2j/jgDxKGlQDDaUwbM6c3RNg7KrCHFK1QkZL6d1Wt2dIljL3+yMcG7TSVDE47txSS
	 Bhq0QsUiQLbKhP4iO+fN6Yii9gWRmAd7lM1f4JNUKQ8muIgcn2J+24AqWPDkOUh50edg0
	 KwIxOR81NJblSion+6KV5TjY/WvFD2aRnx+UWyiKCGuIkNVDPjXFlfKPJVmlUBiZK4Hci
	 oWb5sI5kcATS8oxOQq1L80dvL9J1DznBeNTi7vD5VZkh9xQ0/U3jEhVNry23RveYNRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=PLAAf2By;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB076606A32D;
	Thu, 12 Nov 2026 16:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB076606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=PLAAf2By
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id A8C581605B2;
	Thu, 12 Nov 2026 16:11:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id A56AA1C;
	Thu, 12 Nov 2026 16:11:50 +0000 (UTC)
Date: Thu, 12 Nov 2026 11:11:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Temitope obabi <obabitemitope765@gmail.com>, <mhiramat@kernel.org>,
 <mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?=
 <amadeuszx.slawinski@linux.intel.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Intel: Remove unused intel-sst.h trace header
Message-ID: <20261112111149.1e759122@fedora>
In-Reply-To: <675a6f5a-879f-49c4-a608-d7a82d09d36c@intel.com>
References: <20261111223102.1310-1-obabitemitope765@gmail.com>
	<675a6f5a-879f-49c4-a608-d7a82d09d36c@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: 4e3zsobqqsdkdfybo5nx1zorw4ghtqi6
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: A56AA1C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+vTdWOvtl8k59nbeb9jUlNDXxxl4TQN40=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=0sScZLnu1TmY3yWO4GbI6auwI6UD8n/C/vabFRqYDbQ=; b=PLAAf2BybX+ZaqB8ppDX+jb3cZVVOeY4TGSJIZGiM1TRn+5bgIftpNWaTGmOPhjPQJfGhjq6ELMrUO1/wU2ATA60VVu7nHV9335YdtJkjnEM5POubyKczTReKN8UPrNKDa+Oo8NF6Sdsi15MwsWUg73zGhEbg5IArxx6xkMhk14=
X-HE-Tag: 1794499910-440281
X-HE-Meta: U2FsdGVkX19URGP3wO9F8g60L8gOCKNcO8VyZsEhbkkjYANhYnq0wIKLdhIywbt+LfrVWDKskG+2lpNaFYliZJHAupimTZ4oe/gKasqlgvqg+5FwUkJH5/eMWKGMFRig6lqsNx1bL/7eVjqb2fevnWqo2m7x60gPsteQLSqgnorHhR46Ce3b5bteETHQcRFPfL7s3ApBxLxhawBc8pj8n/akHWx+b1G2NwPJCMUCe2hkvIfI04X8SWp4ujIPZIwy4wFTSQgNCSG+JCTLqXt5BFAkWNcne6UtLFjmfd8eP4VdzyPWbT7qj+V19AxUfpdCLRkdLew7HRVaeLmhZCkzzsM73xkcboWQIUIt8kw7wj7c56FORqVXL/ulCJfZ2cJ44aQ2PfaO9duTEfHKsOytppXWywoAWgT93X77yZm1rFJDdkmUVWQCh+3Vin971X7mYRI36RQUF0LhM18IFc3JgO9S6SelBCiJ

On Thu, 12 Nov 2026 10:53:04 +0100
Cezary Rojewski <cezary.rojewski@intel.com> wrote:

> On 11/11/2026 11:31 PM, Temitope obabi wrote:
> > Commit 970d299b0a0a ("ASoC: Intel: Remove unused code") removed
> > sound/soc/intel/common/sst-dsp.c, the only file that defined
> > CREATE_TRACE_POINTS and included trace/events/intel-sst.h.
> >=20
> > Nothing includes this header anymore, so none of its tracepoints are
> > built. Remove the unused header.
> >=20
> > Signed-off-by: Temitope obabi <obabitemitope765@gmail.com>
> > ---
> > Changes in v2:
> > - Remove the whole header instead of only sst_ipc_inbox_rdata, since
> >   nothing includes it (reported by the Sashiko review of v1).
> > - Drop the Fixes tag and the claim about memory used per tracepoint.
> > - This also replaces the earlier sst_ipc_msg_tx patch for the same head=
er. =20
> Next time, please CC sound/soc/intel maintainers. The very commit starts
> with "ASoC: Intel:".
>=20
> Nitpick: if trace-subsystem maintainers permit ASoC-scoping for
> include/trace, please update the title to: "ASoC: Intel: atom:" to
> highlight which driver it does relate to.

I can make these updates.

>=20
> The nitpick alone is not a reason for re-send.
>=20
> Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>

Thanks for the Ack.

Temitope,

Files in include/trace/events/ are special and unfortunately, the
get-maintainers.pl script doesn't usually work for them. That's because
the headers in that directory really belong to the subsystems that
define tracepoints for.

The best way to find out who to Cc is to find a file where the
tracepoint is used and run get-maintainers on that. Unfortunately, the
file that had them was removed so that wouldn't work either. The next
best thing is to look at the commit that removed the file, and Cc those
that were involved in the removal. In general, you should always Cc
those involved with anything in the commit of the fixes tag (which this
commit should have had for 970d299b0a0a).

 $ git show 970d299b0a0a
[..]
    Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
    Signed-off-by: Amadeusz S=C5=82awi=C5=84ski <amadeuszx.slawinski@linux.=
intel.com>
    Link: https://patch.msgid.link/20241009083419.319038-1-amadeuszx.slawin=
ski@linux.intel.com
    Signed-off-by: Mark Brown <broonie@kernel.org>

All the emails in the above should be Cc'd on changes like this.

Thanks,

-- Steve
