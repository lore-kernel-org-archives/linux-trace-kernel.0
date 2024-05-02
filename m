Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B5B1527BD;
	Thu,  2 May 2024 07:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714633711; cv=none; b=NsR/PxlypwAtiTMxT5QgI9cZnk4GfaPW9I/WiHz92a5qlJZfusT93FaWloz5RS73z/LEbiwA7nojgHQV7sL22+3wUCokl4EYr6Wq84gAbBaXEFCCMSnxXaLtB08GpjI9t/rpfa92/6rvlD4HHVMhuys1rWnUGDtnaExT3gtX8oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714633711; c=relaxed/simple;
	bh=jwAQQgcvlDBD3PKFIiitvp1hnJcuZTvnd950vkUPzC8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VJfnHS/2e//Wb8kHCXERzybjewdgFm+0h+xP6YTGoSPBdP9uxQC3SHN6PFQzQEBya2EtEVgr+EgsenZxm8BdiyydQLulNv6amt9ZO0kz2cBnS9Vlduap9Pnvweu49Ka3fxvO92Iq4JZ5nPnkkdCbdJBBtg51vVfUPP/ENdIF0lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Sr7kHyh2; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Sr7kHyh2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=asVza8Tx0SMAOfx0Xl0rSXcgqp5UqebxCAAIkYewzJ0=; t=1714633708; x=1715238508; 
	b=Sr7kHyh2D5uXEKQwxGBQr/iQxXrWN0sSz/CwBLs/JISjKSb2VtBvLTWln2EAj5HwlMty657AvUm
	ClTxS8CdvPOM6XTUYv5lzineTbKmWTTjRqVWY9TEu9uuPdBshD50T9MC3sHHxrUaGno6nuknb9c65
	Kq5eui61bsURnYW/gJ+tNlx0LeOZrd3pBWQKEurvRmQwz1JiDh+mDfuqHWLsPEepv2LMPZmWwHdhi
	n0ygCeSpZWZM581Q+bLfClXuwMUxnXIZFVs6SXwpOmxstmAhbCYqdDn22EgY0z6Yeu51ze9RAsgGE
	5Ty2FHthowB6uKd98cRIFNgDwaPsjE/OyN5w==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s2QYD-00000000J20-1UoH; Thu, 02 May 2024 09:08:17 +0200
Received: from p57bd90e8.dip0.t-ipconnect.de ([87.189.144.232] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s2QYD-00000003b2C-0VdL; Thu, 02 May 2024 09:08:17 +0200
Message-ID: <05008f7660cfcfec16bd81da1314a3f9e103bcbb.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 20/20] [RFC] sh: dma: Remove unused functionality
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>,  Arnd Bergmann <arnd@arndb.de>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-sh@vger.kernel.org,  linux-trace-kernel@vger.kernel.org
Date: Thu, 02 May 2024 09:08:16 +0200
In-Reply-To: <CAMuHMdUsVz3ph0AD21a1Xz0CBc9ni4ipdS8AhWRJkywm7K2G4Q@mail.gmail.com>
References: <cover.1709326528.git.geert+renesas@glider.be>
	 <2beb81fdd7592a94329e3c9a6ba56959f6094019.1709326528.git.geert+renesas@glider.be>
	 <4f302ebb109fb0528a7de4f552e78ee0dd9595c0.camel@physik.fu-berlin.de>
	 <950ecbb643db322a953bb048b451702246ca9031.camel@physik.fu-berlin.de>
	 <CAMuHMdUsVz3ph0AD21a1Xz0CBc9ni4ipdS8AhWRJkywm7K2G4Q@mail.gmail.com>
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

On Thu, 2024-05-02 at 09:03 +0200, Geert Uytterhoeven wrote:
> On Wed, May 1, 2024 at 3:58=E2=80=AFPM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > On Wed, 2024-05-01 at 11:12 +0200, John Paul Adrian Glaubitz wrote:
> > > On Fri, 2024-03-01 at 22:02 +0100, Geert Uytterhoeven wrote:
> > > > dma_extend(), get_dma_info_by_name(), register_chan_caps(), and
> > > > request_dma_bycap() are unused.  Remove them, and all related code.
> > > >=20
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> > > I assume we could re-add these again in case we need them, but it wou=
ld be good
> > > if Yoshinori could comment on whether we should keep these functions =
or not.
> >=20
> > I was wondering: Could there be any userland tools using these DMA func=
tions?
>=20
> They cannot be called from userspace, as there is no API for that.
> They can only be called from inside the kernel, or from a kernel module
> (possibly out-of-tree).

OK, thanks for the confirmation. Then I think it's safe to remove them.

I will apply both your series tonight and the rest of the patches except
for the one that moves the paging_init() around as it turns out the current
positioning is intentional.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
