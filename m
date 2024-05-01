Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4FE12C490;
	Wed,  1 May 2024 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714571914; cv=none; b=SzhA98FhPpZ0eA4ziQrux3kI86qk1ZgJ8FbEBLMGZX9TsMQRPcUow+Xw/fNmlwKXYmNirXCHXug9OsyFY8pMo6NCvb/7gRzYGfI1W2qcKQuLyPV0Hpp9QtQb4KS1XXZQUcLL6O4BRrANQWdqnPsL62hYVukCpGXD0DRwQ0Ov7JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714571914; c=relaxed/simple;
	bh=KXMA6S2/STOjTtn9CI2G4eWd/gUV4LAluvfMUdZ9oMI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r+yBS7pYesWUq7xt01Fzf/+XARDm+SJ6yZXC/+JGZAhGjXRdBvdqnm/Sv9W0wpqanFamWT3S0CYMYAfRK22Hu9aEW63/+LZRrryWrzzKq1wXGwLUvOu1/etNK0+HHUCRINmUZmZMKBra73EQ5NSnewEc84HQFSXBJ3pUVz94hP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Fv2P79NJ; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Fv2P79NJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z9TaA6H354+HyHFaEyEBNIjn4HtbsnzNYBKSQ1z8Wac=; t=1714571911; x=1715176711; 
	b=Fv2P79NJ2C0Rknsf9NInBMt8yApyjrKmEJTTBQjaoN1KXq2HaDjUrnuKkCc2FneuTczcf8+BBCN
	MqDeBXH8xDeeF6lpyKFqz8qWJpwYyrNRG8A25nruXyG8diEXt/eHyhB6v9wKMomgKtO+ZlYfxpRmt
	Q0RpVBSiCGkHxfvgrCXc4UEtqH1wRMuBjvnPCqefST9xdK1Va4qQOvwXAW32runopS24m8+ByS6nJ
	PH5iKv2MTvrxRn0Lob8ThaD0H1HvUJlOsNhC5R3LM1aE02IFM2DOYCahvzo0RlsQmLKjbWg67iwAT
	t0hnMbLuKh/LoUEY1dzbEBIBjol3KBqMBu0g==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s2ATS-00000001Dlj-3gog; Wed, 01 May 2024 15:58:18 +0200
Received: from p57bd90e8.dip0.t-ipconnect.de ([87.189.144.232] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s2ATS-00000001Ah5-2gDf; Wed, 01 May 2024 15:58:18 +0200
Message-ID: <950ecbb643db322a953bb048b451702246ca9031.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 20/20] [RFC] sh: dma: Remove unused functionality
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Arnd Bergmann
	 <arnd@arndb.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mark Rutland <mark.rutland@arm.com>, Will Deacon
 <will@kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,  Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-sh@vger.kernel.org,  linux-trace-kernel@vger.kernel.org
Date: Wed, 01 May 2024 15:58:17 +0200
In-Reply-To: <4f302ebb109fb0528a7de4f552e78ee0dd9595c0.camel@physik.fu-berlin.de>
References: <cover.1709326528.git.geert+renesas@glider.be>
	 <2beb81fdd7592a94329e3c9a6ba56959f6094019.1709326528.git.geert+renesas@glider.be>
	 <4f302ebb109fb0528a7de4f552e78ee0dd9595c0.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Geert,

On Wed, 2024-05-01 at 11:12 +0200, John Paul Adrian Glaubitz wrote:
> Hi Geert,
>=20
> On Fri, 2024-03-01 at 22:02 +0100, Geert Uytterhoeven wrote:
> > dma_extend(), get_dma_info_by_name(), register_chan_caps(), and
> > request_dma_bycap() are unused.  Remove them, and all related code.
> >=20
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  arch/sh/drivers/dma/dma-api.c | 116 ----------------------------------
> >  arch/sh/include/asm/dma.h     |   7 --
> >  2 files changed, 123 deletions(-)
> >=20
> > diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-ap=
i.c
> > index f49097fa634c36d4..87e5a892887360f5 100644
> > --- a/arch/sh/drivers/dma/dma-api.c
> > +++ b/arch/sh/drivers/dma/dma-api.c
> > @@ -41,21 +41,6 @@ struct dma_info *get_dma_info(unsigned int chan)
> >  }
> >  EXPORT_SYMBOL(get_dma_info);
> > =20
> > -struct dma_info *get_dma_info_by_name(const char *dmac_name)
> > -{
> > -	struct dma_info *info;
> > -
> > -	list_for_each_entry(info, &registered_dmac_list, list) {
> > -		if (dmac_name && (strcmp(dmac_name, info->name) !=3D 0))
> > -			continue;
> > -		else
> > -			return info;
> > -	}
> > -
> > -	return NULL;
> > -}
> > -EXPORT_SYMBOL(get_dma_info_by_name);
> > -
> >  static unsigned int get_nr_channels(void)
> >  {
> >  	struct dma_info *info;
> > @@ -101,66 +86,6 @@ int get_dma_residue(unsigned int chan)
> >  }
> >  EXPORT_SYMBOL(get_dma_residue);
> > =20
> > -static int search_cap(const char **haystack, const char *needle)
> > -{
> > -	const char **p;
> > -
> > -	for (p =3D haystack; *p; p++)
> > -		if (strcmp(*p, needle) =3D=3D 0)
> > -			return 1;
> > -
> > -	return 0;
> > -}
> > -
> > -/**
> > - * request_dma_bycap - Allocate a DMA channel based on its capabilitie=
s
> > - * @dmac: List of DMA controllers to search
> > - * @caps: List of capabilities
> > - *
> > - * Search all channels of all DMA controllers to find a channel which
> > - * matches the requested capabilities. The result is the channel
> > - * number if a match is found, or %-ENODEV if no match is found.
> > - *
> > - * Note that not all DMA controllers export capabilities, in which
> > - * case they can never be allocated using this API, and so
> > - * request_dma() must be used specifying the channel number.
> > - */
> > -int request_dma_bycap(const char **dmac, const char **caps, const char=
 *dev_id)
> > -{
> > -	unsigned int found =3D 0;
> > -	struct dma_info *info;
> > -	const char **p;
> > -	int i;
> > -
> > -	BUG_ON(!dmac || !caps);
> > -
> > -	list_for_each_entry(info, &registered_dmac_list, list)
> > -		if (strcmp(*dmac, info->name) =3D=3D 0) {
> > -			found =3D 1;
> > -			break;
> > -		}
> > -
> > -	if (!found)
> > -		return -ENODEV;
> > -
> > -	for (i =3D 0; i < info->nr_channels; i++) {
> > -		struct dma_channel *channel =3D &info->channels[i];
> > -
> > -		if (unlikely(!channel->caps))
> > -			continue;
> > -
> > -		for (p =3D caps; *p; p++) {
> > -			if (!search_cap(channel->caps, *p))
> > -				break;
> > -			if (request_dma(channel->chan, dev_id) =3D=3D 0)
> > -				return channel->chan;
> > -		}
> > -	}
> > -
> > -	return -EINVAL;
> > -}
> > -EXPORT_SYMBOL(request_dma_bycap);
> > -
> >  int request_dma(unsigned int chan, const char *dev_id)
> >  {
> >  	struct dma_channel *channel =3D { 0 };
> > @@ -213,35 +138,6 @@ void dma_wait_for_completion(unsigned int chan)
> >  }
> >  EXPORT_SYMBOL(dma_wait_for_completion);
> > =20
> > -int register_chan_caps(const char *dmac, struct dma_chan_caps *caps)
> > -{
> > -	struct dma_info *info;
> > -	unsigned int found =3D 0;
> > -	int i;
> > -
> > -	list_for_each_entry(info, &registered_dmac_list, list)
> > -		if (strcmp(dmac, info->name) =3D=3D 0) {
> > -			found =3D 1;
> > -			break;
> > -		}
> > -
> > -	if (unlikely(!found))
> > -		return -ENODEV;
> > -
> > -	for (i =3D 0; i < info->nr_channels; i++, caps++) {
> > -		struct dma_channel *channel;
> > -
> > -		if ((info->first_channel_nr + i) !=3D caps->ch_num)
> > -			return -EINVAL;
> > -
> > -		channel =3D &info->channels[i];
> > -		channel->caps =3D caps->caplist;
> > -	}
> > -
> > -	return 0;
> > -}
> > -EXPORT_SYMBOL(register_chan_caps);
> > -
> >  void dma_configure_channel(unsigned int chan, unsigned long flags)
> >  {
> >  	struct dma_info *info =3D get_dma_info(chan);
> > @@ -267,18 +163,6 @@ int dma_xfer(unsigned int chan, unsigned long from=
,
> >  }
> >  EXPORT_SYMBOL(dma_xfer);
> > =20
> > -int dma_extend(unsigned int chan, unsigned long op, void *param)
> > -{
> > -	struct dma_info *info =3D get_dma_info(chan);
> > -	struct dma_channel *channel =3D get_dma_channel(chan);
> > -
> > -	if (info->ops->extend)
> > -		return info->ops->extend(channel, op, param);
> > -
> > -	return -ENOSYS;
> > -}
> > -EXPORT_SYMBOL(dma_extend);
> > -
> >  static int dma_proc_show(struct seq_file *m, void *v)
> >  {
> >  	struct dma_info *info =3D v;
> > diff --git a/arch/sh/include/asm/dma.h b/arch/sh/include/asm/dma.h
> > index c8bee3f985a29393..6b6d409956d17f09 100644
> > --- a/arch/sh/include/asm/dma.h
> > +++ b/arch/sh/include/asm/dma.h
> > @@ -56,7 +56,6 @@ struct dma_ops {
> >  	int (*get_residue)(struct dma_channel *chan);
> >  	int (*xfer)(struct dma_channel *chan);
> >  	int (*configure)(struct dma_channel *chan, unsigned long flags);
> > -	int (*extend)(struct dma_channel *chan, unsigned long op, void *param=
);
> >  };
> > =20
> >  struct dma_channel {
> > @@ -118,8 +117,6 @@ extern int dma_xfer(unsigned int chan, unsigned lon=
g from,
> >  #define dma_read_page(chan, from, to)	\
> >  	dma_read(chan, from, to, PAGE_SIZE)
> > =20
> > -extern int request_dma_bycap(const char **dmac, const char **caps,
> > -			     const char *dev_id);
> >  extern int get_dma_residue(unsigned int chan);
> >  extern struct dma_info *get_dma_info(unsigned int chan);
> >  extern struct dma_channel *get_dma_channel(unsigned int chan);
> > @@ -128,10 +125,6 @@ extern void dma_configure_channel(unsigned int cha=
n, unsigned long flags);
> > =20
> >  extern int register_dmac(struct dma_info *info);
> >  extern void unregister_dmac(struct dma_info *info);
> > -extern struct dma_info *get_dma_info_by_name(const char *dmac_name);
> > -
> > -extern int dma_extend(unsigned int chan, unsigned long op, void *param=
);
> > -extern int register_chan_caps(const char *dmac, struct dma_chan_caps *=
capslist);
> > =20
> >  /* arch/sh/drivers/dma/dma-sysfs.c */
> >  extern int dma_create_sysfs_files(struct dma_channel *, struct dma_inf=
o *);
>=20
> I assume we could re-add these again in case we need them, but it would b=
e good
> if Yoshinori could comment on whether we should keep these functions or n=
ot.

I was wondering: Could there be any userland tools using these DMA function=
s?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
