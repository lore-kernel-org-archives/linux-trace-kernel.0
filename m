Received: from yyz.mikelr.com (yyz.mikelr.com [170.75.163.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8AD13B297;
	Tue, 22 Oct 2024 03:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.75.163.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729567443; cv=none; b=hkgMbQIAbm7o8LMJrWuHMBofwh3MPmK+TadKFLpAW353yxYsaB9VXDV5DGe17P8QGjI3X2pL1CzBTw+mxKWBc+ai06OIkTrJS8RmLpxzSCKI5Pw4gQnYknbrVRrS/WfDjPIm6MUaQrVukJtXI4WEvHmoQN3E1kxmwRN1l/873K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729567443; c=relaxed/simple;
	bh=agnfK24D1Yckr5UF3L0PseJtUdVRlECbtIOOQQXBbOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MAZ9rWvCfAT/v4iOcq4hh/frgt+fjT0kj9hkZWrvF8cRMg/F0o2pIQVYoxQAqF4uVnrafkTUrCLwkqhIktoOpaTvfduTbnb6XC8Nfbu81gauoActflmtUtYxwRMJRfw9mcbBnLj5GvZtP85nDe3cwjGT6VqMrRlHDdQLMOcaMms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mikelr.com; spf=pass smtp.mailfrom=mikelr.com; arc=none smtp.client-ip=170.75.163.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mikelr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mikelr.com
Received: from basin.localnet (unknown [IPv6:2607:f2c0:e554:1200:4b8f:795f:f483:85bf])
	by yyz.mikelr.com (Postfix) with ESMTPA id 9963D71AFA;
	Mon, 21 Oct 2024 23:14:54 -0400 (EDT)
From: Mikel Rychliski <mikel@mikelr.com>
To: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/probes: Fix MAX_TRACE_ARGS limit handling
Date: Mon, 21 Oct 2024 23:14:54 -0400
Message-ID: <5391163.OV4Wx5bFTl@basin>
In-Reply-To: <20240930202656.292869-1-mikel@mikelr.com>
References:
 <20241001004050.972e999c644d0e45fd2a94f8@kernel.org>
 <20240930202656.292869-1-mikel@mikelr.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, September 30, 2024 4:26:54 P.M. EDT Mikel Rychliski wrote:
> V1 -> V2: Return error instead of dropping excessive arguments

Hi Masami,

Thanks for the feedback so far. Was wondering if you had a chance to look at 
the updated patch?

Thanks,
Mikel


