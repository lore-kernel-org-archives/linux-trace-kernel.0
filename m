Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1535D500AAA;
	Mon, 19 Oct 2026 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419793; cv=none; b=UxNIv1SOXSGcOV56aHy1XIHywcbRXWHaJjc99qSDr2Q60Tb0aKDV1/AmITR34benAKE+eLgVUhnQ8VoEK6FTvq+KoO2WC1ra8eZ+BJgm6rNxLPBmC92jbazLhdVQinUNPUVI4LUMXK3s2yb3vyvu9dnXtN0kkaakE18ZN4TJ+2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419793; c=relaxed/simple;
	bh=288G6ZkP2IAWpQEIeZbZty616TSVrLNM20CIAcij03Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gbb3yP6VV3Z7TVEnHRXig6BCd1+sLy36bbQp5hLUdCo/o4oGv9zvcAI4Td1+JWaNc3Ekc1TXlx1n9zfJEpuRXWwAobuFolId1G2x1p4Lw/pC0/FxPrFyXLFKbgkmmNtn6tt2OGKchnce9xlxY3wpCyJAGLyKCm2ub4GHlGQCJSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dhWMWHFx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dhWMWHFx"
Received: from jeffbarnes-ThinkPad-P14s-Gen-2i.lan (unknown [52.167.112.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id E047420B716D;
	Mon, 19 Oct 2026 07:23:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E047420B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792419785;
	bh=288G6ZkP2IAWpQEIeZbZty616TSVrLNM20CIAcij03Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dhWMWHFxSR2PoZrSSjuwhpmGo96p76hUdolv69o6rSxa19STqhNwVhy1wLNCq/H6F
	 Ko2TvPM34VrS2314ORQa4F4x0eR+mGwABjhbTlTgVVJsQsUjHSkGs3EW48+nYzqyZw
	 wgWhKYlZ1KkQxflcdfZnQSaKinIIw9m+/4jHX9RU=
From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	shuah@kernel.org
Cc: beaub@linux.microsoft.com,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] tracing/user_events: Share state with existing threads
Date: Mon, 19 Oct 2026 10:23:01 -0400
Message-ID: <20261019142301.2084882-1-jeffbarnes@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006164720.3940272-1-jeffbarnes@linux.microsoft.com>
References: <20261006164720.3940272-1-jeffbarnes@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gentle ping on this series.

Please let me know if there are any further comments or changes you'd like me to make.

Thanks,
Jeff
