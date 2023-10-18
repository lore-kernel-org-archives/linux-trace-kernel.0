Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1FA15AD8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Z3Eam9Yb"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A206895;
	Wed, 18 Oct 2023 07:43:41 -0700 (PDT)
Received: from pwmachine.localnet (unknown [188.24.154.80])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3C3C020B74C0;
	Wed, 18 Oct 2023 07:43:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3C3C020B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1697640221;
	bh=bvtQ5UDBEoNT88kyfFrFdb/L/EOTCSplYYH3p4SHGNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3Eam9YbNcBAkTp8qQf6XTj3bQQGw+5fIpC8uHajKjgB5VgpXcApBhaEGCi0pGyYa
	 vPW/Tt3qMm0BJABNCVBZnZQhqYy1DoAF1YUL4KpxqbVSNw8B9OhddWKtY5ZmUw56GT
	 C17+b/E3eXIp65QTIb/LCnutEnuW2b839IH+zJiY=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols
Date: Wed, 18 Oct 2023 17:43:36 +0300
Message-ID: <12305596.O9o76ZdvQC@pwmachine>
In-Reply-To: <20231018153020.fac28cf4381b57e179104b02@kernel.org>
References: <20230824160859.66113-1-flaniel@linux.microsoft.com> <2696412.mvXUDI8C0e@pwmachine> <20231018153020.fac28cf4381b57e179104b02@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi!

Le mercredi 18 octobre 2023, 09:30:20 EEST Masami Hiramatsu a =E9crit :
> Hi Francis,
>=20
> On Thu, 31 Aug 2023 09:14:55 +0200
>=20
> Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > Hi.
> >=20
> > Le mercredi 30 ao=FBt 2023, 01:57:19 CEST Steven Rostedt a =E9crit :
> > > On Fri, 25 Aug 2023 22:13:21 +0900
> > >=20
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > > > Excellent catch! Thank you, I will apply this patch and send v4
> > > > > right
> > > > > after. Regarding test, do you think I can add a test for the
> > > > > EADDRNOTAVAIL case?>
> > > >=20
> > > > Hmm, in that case, you need to change something in tracefs/README so
> > > > that
> > > > we can identify the kernel has different behavior. Or we have to
> > > > change
> > > > this is a "Fix" for backporting.
> > >=20
> > > I prefer this to be a Fix and backported.
> >=20
> > This makes sense, I will send v5 to stable mailing list too!
>=20
> I missed this a while. did you send v5 ? I could not find in my mbox.

Sorry, I took a bit of time before sending the v5 as I wanted to wait for=20
Alessandro patchset to be merged first.
As it seems more work is needed on his contribution I think we can go with=
=20
this fix first.

> Thank you,
>=20
> > > Thanks,
> > >=20
> > > -- Steve
> >=20
> > Best regards.

Best regards.


