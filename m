Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17D043D510
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Oct 2026 05:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790833421; cv=none; b=gJ3h+Q3g0eh4c3FbF0Dag4y1khsmb/XhhR0/rYiqd3thgbIZ3cD4gzJE8/kC4rygdW6KQFR+AP1A5N8G5iiGMgy+6I1aAFaUS3ru7Ns8LXRdDA/5NsBam1ank+gTpnde7kkXLyqfqqulnZAsIJO+P3eedJCWvk5RLv0NJCXJmqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790833421; c=relaxed/simple;
	bh=rcxUxarvckFEbzwc+77lGqnMQwy+i+2zfogoe1pGPuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bg+gJXkUON82lW2xOdimeg1AUUreMGzPt23W/T24kVJ1MmQCPUPlJFxYCFCyAwpHP2pcIaEVX+sZv387/QJwVxHrrXU0lzD8xiYDGbwMKDKe42yimA4ibmM4HnTBw6ssNc/DiMKA54+ctN97MBHUCuLurU2RSNKXkC7chdjdiyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ih0YrXAC; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ih0YrXAC"
Received: by mail-pj2-f38.google.com with SMTP id d9443c01a7336-2e2d9fdf798so9201135ad.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 22:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790833418; x=1791438218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zgvrIEOpw88VrEORT9HbHbyuQrZfBbC4ttbFKpwgFuw=;
        b=ih0YrXAClCgFBCn9SASE45n0KaQdTZ8sJoUMQOnUf8WH3BD1LIfrruRykCRU1vYoeO
         +JIpWL81LBuL/fJHeNPsCvUMiL+CyjIGo2FipCNL00ln5x9BKDkDNI67yglabz31gfAG
         13ut3ETxcZHXx2pJII9NFqw7+srZD48spPcXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790833418; x=1791438218;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zgvrIEOpw88VrEORT9HbHbyuQrZfBbC4ttbFKpwgFuw=;
        b=Ff1iYXVdgx4GhedlQ0Q9I0tLGu8brMil+zDFRnDrmlc1BR78ZldkiMxpYneylG5DEK
         ciepFDTqCusmI+nImirxajHT5wsbxWKYjJVJIvu6EsjuY69FBFB54qBKjhD6+45BFTpj
         yPAcwDwHQXJijuauFC1w9YSx57oZGjDalLpZE1OaMrFW0DfTUuHmLb/smBoX5MgM16cV
         JE/8El89CPa5jR8aG2KEWAh6ebbkWVOPdzNm3WznxqWQttjZBe7L0rgpov2tcVAdP+5q
         SZ64rJcC6AztD5S0b7Ypr7R8ZT3tu3EhgLk/qdOeV2QcrSWQkMQu4nkg/Pj7VGjSvd0S
         1kdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxEB73SyApLFxB8Tj7+i3WgohdJCo5QVBdnfxGVLwPsVF5PZev/iSkTiEIwqMX9eX0/iW4RaUH7esQ2KJzLA6JhmN4=@vger.kernel.org
X-Gm-Message-State: AFuF++nZokWJWDZqNgTqE8rxyocnrio9YHvAZatLMjEtNRhDjc4miV+i
	c2FSx0ogMXcepYZid4i+CyUNiTSI7mQYIey3XgkmAtQliS8VOhubK0yGxmal3V9Xag==
X-Gm-Gg: AYBFou16hzhJUjmI0JOjJOPy4/NnBys66iVrb4phLrkw4LkPiES40LAfulv6l3njRPJ
	o8K0q9wkkkJcLkQYJYEeqYrwZ24iLTIxfim3KO9QJzNb+4L3M9HX0bYfE7PcPzMgoJ882UF2e8W
	K/W2CAOUCpovcrVQHTcvcROLb4jxOf6rRFwyLUOWaySbxYFfzeA0TaqyCcnP4SBu2p4N954vZ9v
	1H3NxkDT/UPiKbT5sSQK7FOhQ1UijE/M7HgjetmodUBKk5WaPSAxeiYxy0q9QeI4afGD6YeuI4T
	QD9J5vT62nbc3jdXgbwowsUsrAnfvKW+6w3sIVx75ydeMe8qFkUBxp/43Lbdq0wFLY3yadlq8pQ
	IA/CEt1Ny8fmyoq6NXwyTrOxHnbgRC/drtEvsz3Iw5iVNyuE8ubDck1OHDQ5tWl+Fz/ADIsVE9t
	aNHMKrHfnkdZ6+XOk7t+pu7a9mjrLAYt44LPOVpd60RtdHh51Y2VzaVvHHb0WNz9PGO/NYUxIES
	VzWtlSd/uhtrqOSoMrvt97DgdGZNb8cRmHnNCEvRVfMTOlm0Q==
X-Received: by 2002:a17:903:3503:b0:2e1:24ec:df50 with SMTP id d9443c01a7336-2e2e499e1c7mr26745355ad.21.1790833418058;
        Wed, 30 Sep 2026 22:43:38 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:d042:b5fa:ebeb:ace6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e30cc14cbbsm1942765ad.37.2026.09.30.22.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 22:43:37 -0700 (PDT)
Date: Thu, 1 Oct 2026 14:43:32 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, minchan@kernel.org, 
	senozhatsky@chromium.org, axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	djakov@kernel.org
Subject: Re: [PATCH 4/6] zram: Add QPaCE zcomp backend
Message-ID: <ar3yt8Kl3WUV93lP@google.com>
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-5-georgi.djakov@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930145215.3380977-5-georgi.djakov@oss.qualcomm.com>

On (26/09/30 07:52), Georgi Djakov wrote:
[..]
> @@ -80,10 +87,10 @@ static const struct zcomp_ops *lookup_backend_ops(const char *comp)
>  
>  	while (backends[i]) {
>  		if (sysfs_streq(comp, backends[i]->name))
> -			break;
> +			return backends[i];
>  		i++;
>  	}
> -	return backends[i];
> +	return NULL;
>  }

This hunk looks unrelated to the patch in question.
