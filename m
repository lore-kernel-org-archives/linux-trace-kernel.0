Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9373F4E1A2;
	Wed,  1 May 2024 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714554599; cv=none; b=b9fIngPelotbcA31ETJEJbx2bollj8b8UgGTi84+jAuAQcEo11VoLwcUJdsiql0vijZqlERzlt9NmY50ct5aYqm4jxlfvbloP82OLo/Y/CbQHHjVnJLH5SvO96dGLYzKfHCWa4fpryzt6p/c2kUeKcw8IKeckkRK9aUddkHXspU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714554599; c=relaxed/simple;
	bh=pjn9enjy/0KE8GlEJdfZTHFMjHo736KV0mJOhjb+7ck=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XMJvQnBdUQ5BarTww50SGuz6TQmL0T5SwZ6Gp4wsTVYvXWrAZscfQgRjHnyqspLjp+tXeWdkNlu33k85UpBu5T/Lud0CzQZpE03wnLYOJAQLNN3sDJm4aQ9HFCEctw76sDsmLl0Seoazbo8EtOBsz/kJTX17levIIqdW+KgVjk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=EwgTV+iU; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="EwgTV+iU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mCXKg/2rJaV1nKikj6RKj4+8wgw2HtVfMTjYV5btcBM=; t=1714554595; x=1715159395; 
	b=EwgTV+iUI/xIg85qFcMNesjxe5gFSSHqP0ksOzzuE2JBSG0jv1/gdekPUtTCe8vzTbb0hIg85aO
	3QcxJciCmfhHjibIOvqtdsuqMcLmiESlggm7LVmF0O606O6/7SzAynVkERa78fnW7GkUgEVE43v4C
	PQpLH1hFYin2tEPEfS2A90/k23Vnbv/iq5Akt175SXZzj3jLdDuTF6ivfhAfUCb563GGSLnvTPowx
	/SaP6D4JmVT3p630Xato6c2pK7QgRFRyzRlqKIgfMCwk8kVsXPSA2Z78ZTfhqDXNdegSJRpq0AhV1
	lKK1Vgj23OWYm6/BHr3X4PTACF0f6Lk8Uamg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s25yC-000000003B6-2IvE; Wed, 01 May 2024 11:09:44 +0200
Received: from dynamic-078-054-136-214.78.54.pool.telefonica.de ([78.54.136.214] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s25yC-000000005Tf-1Jhg; Wed, 01 May 2024 11:09:44 +0200
Message-ID: <44019debdd26c1a4c75362b7a1f2bfaf9be2c792.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 12/20] sh: dma: Remove unused dmac_search_free_channel()
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
Date: Wed, 01 May 2024 11:09:43 +0200
In-Reply-To: <82d5efdde44f9489c5a7d11d0a19750445116c95.1709326528.git.geert+renesas@glider.be>
References: <cover.1709326528.git.geert+renesas@glider.be>
	 <82d5efdde44f9489c5a7d11d0a19750445116c95.1709326528.git.geert+renesas@glider.be>
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

On Fri, 2024-03-01 at 22:02 +0100, Geert Uytterhoeven wrote:
> arch/sh/drivers/dma/dma-api.c:164:5: warning: no previous prototype for '=
dmac_search_free_channel' [-Wmissing-prototypes]
>=20
> dmac_search_free_channel() never had a user in upstream, remove it.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> dma_extend(), get_dma_info_by_name(), register_chan_caps(), and
> request_dma_bycap() are also unused, but don't trigger warnings
> ---

I assume the other functions didn't trigger a warning because their symbols
were exported. Correct me if I'm wrong.

Adrian

>  arch/sh/drivers/dma/dma-api.c | 27 ---------------------------
>  1 file changed, 27 deletions(-)
>=20
> diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-api.=
c
> index 89cd4a3b4ccafbe2..f49097fa634c36d4 100644
> --- a/arch/sh/drivers/dma/dma-api.c
> +++ b/arch/sh/drivers/dma/dma-api.c
> @@ -161,33 +161,6 @@ int request_dma_bycap(const char **dmac, const char =
**caps, const char *dev_id)
>  }
>  EXPORT_SYMBOL(request_dma_bycap);
> =20
> -int dmac_search_free_channel(const char *dev_id)
> -{
> -	struct dma_channel *channel =3D { 0 };
> -	struct dma_info *info =3D get_dma_info(0);
> -	int i;
> -
> -	for (i =3D 0; i < info->nr_channels; i++) {
> -		channel =3D &info->channels[i];
> -		if (unlikely(!channel))
> -			return -ENODEV;
> -
> -		if (atomic_read(&channel->busy) =3D=3D 0)
> -			break;
> -	}
> -
> -	if (info->ops->request) {
> -		int result =3D info->ops->request(channel);
> -		if (result)
> -			return result;
> -
> -		atomic_set(&channel->busy, 1);
> -		return channel->chan;
> -	}
> -
> -	return -ENOSYS;
> -}
> -
>  int request_dma(unsigned int chan, const char *dev_id)
>  {
>  	struct dma_channel *channel =3D { 0 };

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
