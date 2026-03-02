Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB7570808
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772443857; cv=none; b=YqBAVE8n+09CK6GZ4RnBDzfhj6TdHell1rvYBQ+w5H4QK7jlXTYKlR8xA0C+zmA4EyR9+/8PvoRYXswEwFRIfVCvWD3vecxEg6hCKRtpKnCXfgEqKurjUNsCvkkPZy4DWQqATGNK2wzkupsbKPYbHpBnBGDcV4zcvQvqZlKE7NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772443857; c=relaxed/simple;
	bh=SkQS32P2isxsZzN0Tpf5AFFSNZCHU5H1VsWyGV3O950=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+JxwhkT9/lCa9lSNxOzPiJlh7tE971pRJECVJlkkUWZ1XvSaFCQmnqrMu01Amx0XCS31MqdZRjzfdePZOnZx2UY0s5RE28lsWAjs4DAqToE8MLc2RKSHy5tUfusMTA28RYRM52zf9Gu/7c07z9WpmZebnUaJXrDmXijddzdJYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xxCY8N+f; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xxCY8N+f"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4375d4fb4d4so2993026f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 01:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772443855; x=1773048655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9G+3cg9egGGuETeZt9ogez9f+d5U3nrYRpciNbV9ROE=;
        b=xxCY8N+fbsjMfrshhj4gYM+chOalJaRweaJrL2wTpoGwmLZlUbumL7awGab7yxbwRV
         0mUaxq4c7qj1jSTnk3EAuIK6lSDxxdADCvoZL53octj513wTDSnRi4/R5cdaOh0EHvX4
         DGk6gTh2QKF990FGOy3pDqZQXPQ4Eyp2TM2CNZXQXLZShRMd//Y2twlzATk7O5n9oQev
         vkpPyzwkB82N5P/erQPzm165G7oovxqcTaqbSTAprF205+73zG3jdrNDP9/h9iAZcnG6
         GEwT8qqD5tqVlJ8g2KjgdD0phbqxtqX6t2w5BM7ieSuIOuD9fLRS9AwTGY2Sghwz6Dno
         c4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772443855; x=1773048655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9G+3cg9egGGuETeZt9ogez9f+d5U3nrYRpciNbV9ROE=;
        b=esniqo+/D2YPCTU2KqdkC94tTee6LGMioBJoZ6VDeCi+XhW+kTAcXwzGGhhI//uB/3
         xJa25qLx0PgY4CyRUOrKIZk3Blpcif9Cu2D4aDrxTAi9kjCsF1Q6ffOluBaiAIOrw9L3
         8dV4wNd47TqywFNSOTEACLZX3FqnolPfImltNRRAogu5Jz7opL/AjpBZL18M8x1dVi9t
         oLIDKL2FGf4SN0R7lmnq9vZmgLlx8tTxymIVyuJhFjuJALYFS6olLU5VnObDW4YRw0P4
         jL5ZYnMBIA0ky2wwP0hpp40B5YKvnqy2TDekLs6glJadZp+KpEUfTT1GIfv9mnMSF3Od
         Zt5g==
X-Forwarded-Encrypted: i=1; AJvYcCWG82bHZuIkjttp49XyWmP4tV0xXXMvtMnUt3ZDyMHrAFYdYIlp5+g9msNmmjNZoQ75C5R6WnZeUfzdU7Sd2cK+Tbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlTb0DWzeXKxZIVHzpIBghY/Z+3t8c4Z97ORUKP9YTfPPFb36i
	jPv7oSCe+28p6OilFzSsO+BmW8EIJ2TbI9iEhuy/C4a1C7LhxVgSV0S+AKFqhUQ1ETg=
X-Gm-Gg: ATEYQzz2iNg3Nd8fESOknSSSySCVNoVXAL9dVCTceTy/ucHEqY1FSZsGvkzTgFyQEJZ
	dBJU97Kpinbzg5bi66QCO4g53IWR8fzw6dBsmBWJScJxS+TR5gMaFxgbToBYFsqQ5/gumBPYKAS
	berq/883kXAuafRgS1oi/alPz4i79JwiJ9+Lzz4mqD8EHuaqVVIkmabGfVh+UQNjueGzBKY7ImZ
	av6ypKJnIIxSNq7yPdvjuL3AAJXjsz9Zpawq0gtSwjoMjceNBJ6HRbSPVEscIGpKFXQVixZeWLO
	+MMKkqOcw/fLsLh1JCvy11sTVjrUyx5TsImtkAjfM+dSunjFIPxbXl/Ou+w6+uKIhjmmGXgYATr
	pXj0U/613CuaGSw7XajASGwMG7gASicBJjbnMBn0bIKAe37ONyu8zA00dDuEBmgUa3JPDhidyy6
	AQGBrQHgKQTWDVkw4BzOWsmB6VJU4e8OA=
X-Received: by 2002:a05:6000:601:b0:439:9550:fc57 with SMTP id ffacd0b85a97d-4399dde551dmr19370651f8f.18.1772443854545;
        Mon, 02 Mar 2026 01:30:54 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439abdf5430sm15422817f8f.5.2026.03.02.01.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 01:30:54 -0800 (PST)
Date: Mon, 2 Mar 2026 10:30:51 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, 
	mbloch@nvidia.com, przemyslaw.kitszel@intel.com, mschmidt@redhat.com, 
	andrew+netdev@lunn.ch, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, chuck.lever@oracle.com, matttbe@kernel.org, cjubran@nvidia.com, 
	daniel.zahka@gmail.com, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 08/10] devlink: introduce shared devlink
 instance for PFs on same chip
Message-ID: <cic5snbhrc4lvs5iyuddepj66nyttzpajgcjal4etqebjxlgqo@hwwtlbmczhr6>
References: <20260225133422.290965-1-jiri@resnulli.us>
 <20260225133422.290965-9-jiri@resnulli.us>
 <20260228150311.1a1ded74@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228150311.1a1ded74@kernel.org>

Sun, Mar 01, 2026 at 12:03:11AM +0100, kuba@kernel.org wrote:
>On Wed, 25 Feb 2026 14:34:20 +0100 Jiri Pirko wrote:
>> +struct devlink_shd {
>> +	struct list_head list; /* Node in shd list */
>> +	const char *id; /* Identifier string (e.g., serial number) */
>> +	refcount_t refcount; /* Reference count */
>> +	char priv[] __aligned(NETDEV_ALIGN); /* Driver private data */
>> +};
>
>As pointed out by AI you promised a size member and a __counted_by()
>annotation :)

Yeah, somehow I got false impression this is not needed for priv. My
bad, sorry, adding it.
