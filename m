Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830632868A9;
	Mon, 16 Jun 2025 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750091620; cv=none; b=rLXCAARZhG6J9uaHrdD9TSwWL6EZRdb9YGpfo+cLj5QP3vYNmHSRPz/uwqirxxGW3ffj38HTx0ockZ4aQqW7+owWEaSLw+LxS1IBeKc5pY5tbFAJaUE7m36ghWTb8KvApVy4N2Xi0ZY6SjRe8sucbHTvS0MHazzcI8QqgYv3CEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750091620; c=relaxed/simple;
	bh=Bg97SQKX7kfD8IHsM6SWMxkn29uAD6ke7iCZ+Q/Egz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kdIQUW/QebWhI7PLH5gMl3AjLaMMpC0b+NbLdgo3Kl/Z4mSdpT6WljZha7gsSH6pFofP9+J81DwiG203bBDugK2flWrlGbl3aYKTuzuCBm5JK0gxMtSt6S5Oo50pXicNTLpeughjuMlPoizmA2/j/KjqBP8Jwziw2YRMbh7nnbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=S8ExsSt7; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="S8ExsSt7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Bg97SQKX7kfD8IHsM6SWMxkn29uAD6ke7iCZ+Q/Egz4=; b=S8ExsSt7cKR8OZDBBfKIoMxyU3
	8rwu7OlS2q/fyBVPuJp30ZfG651kfCvOoStNusSGZ5vZ9Iv4NMhlo04w8rDG57ME4f+r2nKhPjxaT
	B/BOnkrpWm4cR8nkn7BIytbrMg1IDq4ivqfnFhZpq1giJog6QJP+VJhTnSMqxfQ67XLtaFXiP/Sn8
	tarht+0RsT1YFQ/mJTFAwA24UZB65sgKDXNqTX6U2kHMFg/HLo04sVqn5qioXbe/cE5woZIwaoCri
	TfSg2Vlt5wwozhH6YTtWQeIc7MC2R4JPWURDLF5HWETYGH2X/2FCpcT3JqggE1amRzqFPXbTbd2pp
	56hON/YQ==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1uRCGe-00FGuj-CV; Mon, 16 Jun 2025 17:01:04 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
	(envelope-from <ben@rainbowdash>)
	id 1uRCGe-00000008pce-0MDN;
	Mon, 16 Jun 2025 17:01:04 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-tegra@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: two tegra drier tracing patches
Date: Mon, 16 Jun 2025 17:01:01 +0100
Message-Id: <20250616160103.2105041-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

I added some tracing to the tegra-mc and the bpmp driver which
the tegra-mc uses. This might be useful to other people so
sending these for review.

[PATCH 1/2] memory: tegra-mc: add tracepoints for tegra mc tracing
[PATCH 2/2] drivers/firware/tegra: add tracing to bpmp code

