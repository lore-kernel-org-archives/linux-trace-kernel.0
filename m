Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD38434EF15;
	Mon, 22 Jun 2026 04:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782103944; cv=none; b=tYNmQkRWyi6og2zI49f9wz4AqiK4OZMBpRiJdIpLcU4hcK5sqh7XuD5dpdMCJRzeSdyFL+B/q6mUO2eAi4i9EWIVYNVQiCOYSnbeglHrOEmLFZ6vtk+yzVw54WWCrV376Y40EZ9dTL3VKhhwMePkGn8qFOJd2J/m7FivlN59T/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782103944; c=relaxed/simple;
	bh=tnKVqoqpoJKMYiizlRVHp4A2dPcUZzzAng0aQg2g+qc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HNtDoCp179d4IoFbgCt/CQFsFUZr2ULHE9mzxC6f6AsEhbUXWlAoi2+IQaaXUP1/t8pXYJxYvxrD+bnCRD1AI35G7dZuQ8MxhUe+mwZWUWA83qBD5edanWKYEXUTkqYgVjtG0XB0PMHIlt/I82YBVmojCSfEGXlhQSDUqOsBYXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+AqXA/l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+AqXA/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992521F000E9;
	Mon, 22 Jun 2026 04:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782103942;
	bh=5foR8cFgnYJ4NgroMqUpgtarUp9o9g370HplsY2MiEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m+AqXA/lENTNmOBppzQGvwVNSjQdFNNtdMbU36RZDzo/gxlk04BSssh9dhoZLGx7O
	 See5Qbhx86g+VvSxTD3bWOUgU52GXGA9I8t9z4kwMSljV7IIkIJFQusLJvceabWIMP
	 Et5xCs1+LonRy41SdaKRXGSy9uPV2CeUWS5g8kM2RZo+h+3UaGt/4dc2r0xJXSgMNn
	 /PaMZhENBcQwjDcT4AC+7opYRaN4mrcIw4KdNhion0uw965zVAJhqdcha2edGKMA5H
	 LUla4SSiSrFRiWrCai+SgOF2INq05eXQyAymCoR693Hi7mtQ3PtpqkkAKqUC1owE2f
	 XL754/1cL801Q==
Date: Mon, 22 Jun 2026 13:52:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] random: Expose boot ID to other subsystems
Message-Id: <20260622135220.6cdf5647df9540f95b5a5e9d@kernel.org>
In-Reply-To: <aiw8OIRYMjWZYhvV@zx2c4.com>
References: <177937541909.2596845.17729857441826694760.stgit@mhiramat.tok.corp.google.com>
	<177937542892.2596845.4271730537688894501.stgit@mhiramat.tok.corp.google.com>
	<aiw8OIRYMjWZYhvV@zx2c4.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jun 2026 19:04:56 +0200
"Jason A. Donenfeld" <Jason@zx2c4.com> wrote:

> On Thu, May 21, 2026 at 11:57:09PM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add get_boot_id() to expose current boot ID to other kernel subsystems.
> > Note that since this is only meaningful if user can access it via sysctl,
> > it returns NULL if CONFIG_SYSCTL=n.
> 
> Wouldn't this be nice to have even on !SYSCTL systems? Why disable it for this
> case?

Unless user reads and records the boot_id, it is just a random number.
Thus it must be exposed to user space.

Anyway, this does not work as I expected, because to generate really
useful random number, user needs to ensure that enough entropy is
collected. If any component uses this from early boot or boot time,
we will generate less unique number.

Thanks,

> 
> > +/**
> > + * get_boot_id - return the boot ID UUID
> > + *
> > + * This function returns a pointer to the boot ID UUID, which is generated on
> > + * demand the first time this function is called. The boot ID is a UUID that
> > + * is unique to each boot of the system.
> > + */
> > +const u8 *get_boot_id(void)
> > +{
> > +	static DEFINE_SPINLOCK(bootid_spinlock);
> > +
> > +	spin_lock(&bootid_spinlock);
> > +	if (!sysctl_bootid[8])
> > +		generate_random_uuid(sysctl_bootid);
> > +	spin_unlock(&bootid_spinlock);
> > +
> > +	return sysctl_bootid;
> > +}
> > +
> >  /*
> >   * This function is used to return both the bootid UUID, and random
> >   * UUID. The difference is in whether table->data is NULL; if it is,
> > @@ -1638,12 +1657,8 @@ static int proc_do_uuid(const struct ctl_table *table, int write, void *buf,
> >  		uuid = tmp_uuid;
> >  		generate_random_uuid(uuid);
> >  	} else {
> > -		static DEFINE_SPINLOCK(bootid_spinlock);
> > -
> > -		spin_lock(&bootid_spinlock);
> > -		if (!uuid[8])
> > -			generate_random_uuid(uuid);
> > -		spin_unlock(&bootid_spinlock);
> > +		/* Ensure that the boot ID is initialized. */
> > +		get_boot_id();
> 
> I find this a little odd, this implicit behavior now that sysctl_bootid ==
> uuid. But perhaps that's the cleanest approach there is?


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
