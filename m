Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31961361969;
	Thu, 10 Sep 2026 01:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005561; cv=none; b=U72rL29BJ4E8yUNpsYjj9bBNYEvbyKQs4+nN7dJoVIARrqoH2SwkmU/y68C+wc+vVJLtwtQbJUKRQ4adoRcvEjhmKJoS9t17aLDdxx8PludMWwvqtvkh1d/ffovBdTd++ANJ+DkOMco9bSi2GlVo52kb4Eh1BLvp17CVNRG7w2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005561; c=relaxed/simple;
	bh=vR3y27VB51LPpgTgeMzHZVisWdESfTLCBH+l3XPtf1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OX0guDYSnjaTqhVGiOJ003uq6He8Qx2/gwQOYCDYT9QhprzyFcm6qc2RR+R7rqIyjPGCcdiRtDEl7u8yO24kzuwkmZUWrzFOFDcHUjO23ps3YfLLM27It/lAQfJjwpSJvJ9xqICQLEv5GpEnG2DqbKZ7SXBsFkSnh2E48grhCTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdqGPMT3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdqGPMT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D241F00898;
	Thu, 10 Sep 2026 01:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789005559;
	bh=2cQTTAJsN/+zaGDpiiWmbmrf3TKZ/hygBQ9jdSoPMLs=;
	h=From:To:Cc:Subject:Date;
	b=SdqGPMT362lllRJDOwW5B5FX8yfsPGgsluRvgLXLh80eO4qwNdRMD91zIpSArzpKX
	 qFF3lKTwCJVVDKV73nnR+dpxigIUExFe2UOk5et3JyVDoLml4bYl0gsWory62BBkcb
	 K0dfeqno1A3JCUCN9P/XPLLtkWuubfAOY43Yz/f7yMATBLhL5vYSTg0NkjlRBWfAoc
	 OBbfBWIg1mIkDx+rFMGWpnpTwa1Rv/V3CrQDTshDXKLIKrIg+rUcXvJzXHBH+JJnWT
	 YQfLyG1zCWh+7LWrofix1UTXQy5XVgqFKcLKZwt7LmU+3H/aq8pWThtOSFi2v9s63d
	 xItklRICO2uUw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Douglas Anderson <dianders@chromium.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH v3 0/2] bootconfig: Fix integer overflow problems
Date: Thu, 10 Sep 2026 10:59:14 +0900
Message-ID: <178900555453.200943.4719889510443114485.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here are patches to fix bootconfig size overflow issue. If there is a wrong
bootconfig size is recorded, it can bypass the size check in the tool and the
kernel.

The previous version only fixes tools, but Sashiko found the same issue in
the kernel. So this version add that fix.

Here is the previous version.

 https://lore.kernel.org/all/178900114498.187028.9558747732041210116.stgit@devnote2/

Thank you,

---

Masami Hiramatsu (Google) (2):
      tools/bootconfig: Fix integer overflow and truncation in size checks
      bootconfig: Fix integer overflow in initrd size check


 init/main.c             |   14 ++++++++++----
 tools/bootconfig/main.c |   13 ++++++++++++-
 2 files changed, 22 insertions(+), 5 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
