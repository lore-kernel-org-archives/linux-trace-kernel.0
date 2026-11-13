Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794538012;
	b=xr4d4h3R3q5Wzdm2uh9oCwMhlA8Ihc8kvq40bpPb4jty6qhnyS0volUxw2fsr3jn2xsR
	 Hm5GpCfXBqFgYqbxTJAwiDfXb73Bn7k/QQMu3JBY8pk4UupHKdvA/u9fcE8ZQ8arz6OUD
	 6WwR4tw7oAGXKudR9h+4ujbgMaUXwgn8jlxvUYZqCcrQ6ctmEyLtoQkl3HORQCbqzOZPt
	 4OelDF6psMRU4YENOAfl3ELYRKpxrG5UC0oVIovapqg/RD4RuTiPFQ2p3LXCYo+QhtppF
	 zct8Q2hpfBLSSVsA1XH7H4eg2rfODMlbzksTH/5lcHK+j66EfmscfxIyNmR9qQVnIXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794538012;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Qkn6ainKMDnoSBWycnnKh5CPzD35jpEbWcYyD/YKj6Y=;
	b=fl2ekIKzm1GMMOrA/EMVpFc4RauHBjo8P8Cx43AJ5/ar9XrDKTI0ZU6qrSYz2Fnor+tr
	 PvqgyxtfuIaouIBeLP+ANs0nvUhaeg1SpzXexLPtLWgjGGCmN0EBv2kTunZwGnMMTk0Wr
	 rXVx+2uAXf56H/FiD3fMrWHBwHctB1IZ0gcvYhTvUMubzMBwtZFrwiXXXREq8jVR1TjgR
	 u53yH/7h23KjTLXoB87k60sd9XJXq2yV/+qlDcPiFJ2RZomVu7ndaL/dXr+Wh8z3zmjSB
	 rhyME/i3LKDtN2twk4LuUzFrD1vbGPzf8oh/+B4c8Olv12Hesvzr7R6Ayij3G2SXPZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gzv6HUVW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3CA606A31C;
	Fri, 13 Nov 2026 02:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gzv6HUVW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839E11F000C4;
	Fri, 13 Nov 2026 02:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794538011;
	bh=Qkn6ainKMDnoSBWycnnKh5CPzD35jpEbWcYyD/YKj6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gzv6HUVWFV8xIC2LVHTu2FgoA7HARmpaij3ADeDyH7aM6TlLrpVewILN7804JyfYz
	 oNVQBhzJQRr3dqTfRdMT3s4ah1+z+NICJ5SkKiPxEPCHodwqXFKDga9SFVMSmNCv2r
	 diqQUVq5YeVBwCm3bfXhwtGvnJv+2zNEsG4SEW+iFJPerCJ4LCF9/Nyw/hFVWPBswG
	 +m7ggpkYaAqBiEBz1u/F3YEiZq9z2HxK1blmm/Yf2HqKzPg2TbUSaAZDjOeHRvf4MO
	 yTXoIZYlNAyERZHhCQy1ggoNdVtg9b7DAnXWcUgKuhr979/wLOceo85toUYi0rh2/5
	 95MNP1AgXsZTQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>, akpm@linux-foundation.org, rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] bootconfig: Preserve values and key paths during parsing and output
Date: Fri, 13 Nov 2026 11:46:48 +0900
Message-ID: <undine-1794538008977732670-2265a2aec6e4af99@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <undine-1794536932799279555-f9c303a1aba9ec59@undined.local>
References: <cover.1794333957.git.edumucelli@gmail.com> <cover.1794337724.git.edumucelli@gmail.com> <undine-1794536932799279555-f9c303a1aba9ec59@undined.local>
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

On Fri, 13 Nov 2026 11:28:52 +0900, Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> On Tue, 10 Nov 2026 20:08:44 +0100, Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com> wrote:
> > Hi Masami,
> > 
> > Thanks again for reviewing the earlier fixes. This v2 addresses the
> > issue Sashiko reported in the first patch.
> > 
> > The parent array in v1 assumed that the parser always enforced
> > XBC_DEPTH_MAX. I reproduced the reported overflow with AddressSanitizer
> > using a 20-component chain where each parent also has a value. The
> > existing verifier skips the subkeys in that case, so the parser accepts
> > a deeper tree than the formatter's array can hold.
> > 
> > Patch 1 now checks the key children to determine whether a node opened
> > braces, using the same conditions as the forward walk. It no longer
> > keeps a depth-indexed array. The existing verifier gap is a separate
> > issue; this revision removes the formatter's dependency on that check.
> > 
> > Changes in v2:
> > - Patch 1: derive brace ownership from the key children.
> > - Patches 2 and 3: unchanged.
> > 
> > I tested this on my Ubuntu machine. All 137 focused checks pass for the
> > combined series, and the full bootconfig suite passes after each patch
> > (86 passed, zero failed for the complete series). I also checked the
> > revised first patch and the combined series with AddressSanitizer and
> > UBSan using value-bearing chains up to 95 components.
> > 
> > Review: https://lore.kernel.org/all/sashiko-outbox-207566@kernel.org/
> > V1: https://lore.kernel.org/all/cover.1794333957.git.edumucelli@gmail.com/
> 
> These looks good to me too.

Wait, let me re-review it.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
