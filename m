Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7D63446C9;
	Fri, 30 Jan 2026 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769766495; cv=none; b=RZDwNdd/Cv5fKcHe+6BJ0COklsZ69Gq+4IHSG/FAGypgDoaZkXRfAsII26wdfQpZMuo62ofg7T1z0Ntm8OrakRA15uG1UYuBAdMHyceVhkb6cQsEAmqk5Z/5Fn8XfNHKj4pN0oErhXhKiiz7LCdAsD+tBT/6dCV3fEeRaXK3ZtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769766495; c=relaxed/simple;
	bh=9EX3E35P6Hg1Iq7h2iJkGkUFnTJjztYiXmMhmEhbRFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fFchBloomA0yBvW4P+1dASJdb/WskGObs9AHa+qH/U0c3rwBmea+SSH8fS5BpepjyFx9yuaNq8g/hQtXVPpB7nx1DUltJbs0ypgSQWUl3Gw527Xgicbr813XX5Y0KVYNHdkw6Xul+/mJESaikIH4QQFbmmbg4cf6twja1QnAKT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bzDuZ0+M; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bzDuZ0+M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769766493; x=1801302493;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=9EX3E35P6Hg1Iq7h2iJkGkUFnTJjztYiXmMhmEhbRFM=;
  b=bzDuZ0+MNEE4LPD/COGagQ0Pkjo53xUMIAhcvbKx/VlclThituHsuvAq
   Hn05HtVGCuXaNQhi6YsTvBiyg6fOexYf2a+NH2LFgr5aVp0AL1IONU9Xe
   Ib69+3ip8Uweetb+zAqUgDaTH4S7PK1M8vmV0uh1bao1yfHOmn/Ksa/xV
   U6Khw8v0M90n+8QJWGIlnY1aV4rEpxIbwMujkRw4BcCVk8Uf8IuVtRyi6
   UDFYNGKgBfgtjMOZcUVDWqp8LYx0hWN7X6UaZgMAwzb+PhoL+9K20Hrek
   T1pHqt0jfowBiydj2ajYwfAO/wMpfPxKO6VPTbJ7Ef9Jw5jpyo9R1AzuU
   w==;
X-CSE-ConnectionGUID: mCbdq9pbR6WEXzwQna2D6A==
X-CSE-MsgGUID: V0DYvXWAS2eo6zW23h/i1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="74640839"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="74640839"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 01:48:12 -0800
X-CSE-ConnectionGUID: poeentPyTEmvZx/1oQTsMQ==
X-CSE-MsgGUID: xtlOClocSheYT7NO0kaQ2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="240078451"
Received: from black.igk.intel.com (HELO black) ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 01:48:07 -0800
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Yingchao Deng <yingchao.deng@oss.qualcomm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet
 <corbet@lwn.net>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, quic_yingdeng@quicinc.com, Tingwei
 Zhang <tingwei.zhang@oss.qualcomm.com>, Yuanfang Zhang
 <yuanfang.zhang@oss.qualcomm.com>, Jinlong Mao
 <jinlong.mao@oss.qualcomm.com>, Yingchao Deng
 <yingchao.deng@oss.qualcomm.com>, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v5] stm: class: Add MIPI OST protocol support
In-Reply-To: <20260129-p_ost-v5-1-2b14fff39428@oss.qualcomm.com>
References: <20260129-p_ost-v5-1-2b14fff39428@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 10:48:05 +0100
Message-ID: <83qzr7a0tm.fsf@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yingchao Deng <yingchao.deng@oss.qualcomm.com> writes:

> +	for (i = 1; i < ARRAY_SIZE(str_ost_entity_type); i++) {
> +		if (i == pn->entity_type)
> +			sz += sysfs_emit_at(page, sz, "[%s] ", str_ost_entity_type[i]);
> +		else
> +			sz += sysfs_emit_at(page, sz, "%s ", str_ost_entity_type[i]);
> +	}

Greg hates this. Documentation [0] says "preferably": "Attributes should
be ASCII text files, preferably with only one value per file.", but
somebody will get yelled at if this gets spotted, and since it's
probably going to be me, let's maybe not do this.

Also, the ST Microsystems people don't need to be CC'd on Software Trace
Module patches: it's the same TLA meaning 2 different things. Everybody
does this, so I'm assuming they're cool with it, but FYI.

[0] https://docs.kernel.org/filesystems/sysfs.html#attributes

Thanks,
--
Alex
