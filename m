Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBAD2EEE7E
	for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Sep 2026 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788909904; cv=none; b=GTW7J2iHSVqdhecLbB/ymgDHRFH6avPZ7Qi3W2p0gX21BJ882GkkG4WGeKhP15KEBA78t+V0b6WSeX3dzznTjpkPsNVPVmKiD95w5dRd+6a9Ld4KMtbswifkVIdtqMeNhU54ybkc+xUHeFHcjNtVgmBubqjjTMqbWekwrqKTeYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788909904; c=relaxed/simple;
	bh=E9dbkJaeDn7PwERbk9AzYAh4G6f6cCO5jVjbDGtLLl8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Lyvhmj9QMPgS8tSeUt/DiCN2v+7/0Sxs5kcu+LWrFb1wQ76N2M4zWxTaCaFDmThpawzf4Nr98FcxpZDP9Dm5TH7jfYThEoRVRxLMgeUKFDVMbhjfCjy1Fjz4Upc2U4rZuYuNyIYH5wgtP6AxRqwA/biXVN3Ylco6kwbShTe9fpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=au+aqYiV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="au+aqYiV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F481F00A3A;
	Tue,  8 Sep 2026 23:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788909903;
	bh=CLCdocsCypd3wvtDayGuLs/D1QyGIWsP/nDDWefAxFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=au+aqYiVVYuVw6srWDBIjjIBWwuFE1vc6BD1vEJ0cL5zYz/JMdoLpxnA6sVMzYaV2
	 58fhdaYh3s7LCazDePUlKlLvJgMlZJFIQk2+srM6TGMH0f7A0FuZRWTlGw2WNQ0zwU
	 U/zdZQZ5sSJUSN34/9z7Omyw6wpHOe2lwmiW4MOdKA6czSaUznnYv2tVofrIYVxISf
	 Tio6oGZyXiMddK6O5kuup+ogwZtMQycoBKRHR/jkAl/caG1U7/FYX7uBRpI25EO6Sb
	 wpe2CT0GUQ8Zwx7n2e1ModO09OEBqP6itKiLk+Vgs2WS9N7qq3Z7Or70BeBz8ixqVS
	 brEf+kA3b91rw==
Date: Wed, 9 Sep 2026 08:24:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] bootconfig: remove unreachable index checks in
 xbc_verify_tree()
Message-Id: <20260909082459.77701fe379794a39242ebff4@kernel.org>
In-Reply-To: <CABFDxMEot48G141HrLT-4_H1xKez58UhK8yFMNkWpqT_MOXu7Q@mail.gmail.com>
References: <20260905141637.1547429-1-ekffu200098@gmail.com>
	<20260908104629.e7a85a90e376b843dbc51dc7@kernel.org>
	<CABFDxMEot48G141HrLT-4_H1xKez58UhK8yFMNkWpqT_MOXu7Q@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 9 Sep 2026 00:34:35 +0900
Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Hi,
> 
> On Tue, Sep 8, 2026 at 10:46 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Sat,  5 Sep 2026 23:16:36 +0900
> > Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> >
> > > xbc_verify_tree() checks that every node's next and child are below
> > > xbc_node_num. Both fields store the index of an existing node, which
> > > is below xbc_node_num.
> >
> > This is a kind of foolpoof/defensive checking. (so I call it verify.)
> >
> > >
> > > So remove the checks.
> > >
> > > No functional change.
> >
> > Hmm, OK, I think we should decouple the logic/implementation
> > verification from runtime verification (e.g. wrong format)
> > and move the former to tools/bootconfig.
> >
> > Thank you,
> 
> Thanks for the review, Masami.
> 
> To make sure I understand, you mean moving the foolproof check after
> xbc_init() in tools/bootconfig?

Instead of just removing this, move this verification into tools/bootconfig.
(we still need verification of user given broken bootconfig.)
Let me handle it.

Thank you,

> 
> > >
> > > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > > ---
> > >  lib/bootconfig.c | 13 +------------
> > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > >
> > > diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> > > index 89c88e359179..d383430637ee 100644
> > > --- a/lib/bootconfig.c
> > > +++ b/lib/bootconfig.c
> > > @@ -1005,7 +1005,7 @@ static int __init xbc_close_brace(char **k, char *n)
> > >
> > >  static int __init xbc_verify_tree(void)
> > >  {
> > > -     int i, depth;
> > > +     int depth;
> > >       size_t len, wlen;
> > >       struct xbc_node *n, *m;
> > >
> > > @@ -1022,17 +1022,6 @@ static int __init xbc_verify_tree(void)
> > >               return -ENOENT;
> > >       }
> > >
> > > -     for (i = 0; i < xbc_node_num; i++) {
> > > -             if (xbc_nodes[i].next >= xbc_node_num) {
> > > -                     return xbc_parse_error("No closing brace",
> > > -                             xbc_node_get_data(xbc_nodes + i));
> > > -             }
> > > -             if (xbc_nodes[i].child >= xbc_node_num) {
> > > -                     return xbc_parse_error("Broken child node",
> > > -                             xbc_node_get_data(xbc_nodes + i));
> > > -             }
> > > -     }
> > > -
> > >       /* Key tree limitation check */
> > >       n = &xbc_nodes[0];
> > >       depth = 1;
> > > --
> > > 2.43.0
> > >
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Best regards,
> Sang-Heon Jeon


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
