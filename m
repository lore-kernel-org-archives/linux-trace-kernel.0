Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BD0425CD8;
	Wed, 20 May 2026 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302817; cv=none; b=Rmmnhxpv0EUqKtHfAIwbKF5v8t1RXubDgB1Onpnx7TUOAzWO5d4PVZXRossQZ04r7Gx+af1GC+UcFv1dtxsnXPsY/1YUY4FVx/+pPztm6DXubHp9nNERD/N4TJH5nJXYuBy2I32RwRe87EW99KL6QoC+yNw2NISUl2nHN59zrvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302817; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:Date:From:To; b=pCO3fv52SYX7RckflWk9ts4+8UrzJH0VbBh3W7KvSNp1dPzkF0Dr+0rTkO1oeIdeJLO63ereigY55hAxBeCNjytbcAC+1IwR56xIZbO0MhgqOVrk9rNSM0xVUoAWKcDvK96ogMt/VgLp6uPOqMkv+P0EfYy7Pvv1GNKZL5FqAFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQUoJTrn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQUoJTrn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41711F00896;
	Wed, 20 May 2026 18:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779302816;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; h=Date:From:To;
	b=YQUoJTrniFDNn2DpAxDbVeF5MYm2kcBuN+hRf6SlBL2+b3XDS/CmjBoksQvtCOn8i
	 KX1QXe21LJEZucku071sva0iaGQwcK5B9r99Q7uCUWojq53CUkEaiikq3gWIOnEByN
	 eS+wgzsGtkB81sR/vfxI+VLwQrSsRCh8DP66V9qewp81ulsvao/95x/eKwbPJWpcJ7
	 e7hUJB6hs2zg+sKmFgsjMLTD+SZni1kfg/f8n3qpHxQcdybSQWUYT2EQ1MJTmsD2fW
	 BoFZbkBM7B6K2b2M6ynfjk4aCgVbuCmHgiMOcj5cpvr7K8VP0shB4hJUJSq4S6mj/r
	 8tH6CJ7tkDVfw==
Received: from rostedt by gandalf with local (Exim 4.99.2)
	(envelope-from <rostedt@kernel.org>)
	id 1wPlwq-00000004qGN-1UOv;
	Wed, 20 May 2026 14:47:16 -0400
Message-ID: <20260520184716.199133347@kernel.org>
User-Agent: quilt/0.69
Date: Wed, 20 May 2026 14:45:11 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

