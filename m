Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514C8254B17
	for <linux-trace-kernel@vger.kernel.org>; Thu,  8 May 2025 09:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746695666; cv=none; b=KpMwYQDDhPUPcSpMt70iGIg67u9LKVoAlVAr4lIt2OUdVnGi0USH9z/QMruiVwBiHURJLMdqtLTroIGm4UgtmyjMCicZlCgNgelqiXUo8ADruxC0GdAz3UObC+7krhlhiytbjZHUs8jpeJ2Utb63UNCIJoc5kKAudgqTtJPVCG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746695666; c=relaxed/simple;
	bh=2LdP/A4VnpSZ8Arqppmfa4jFk7aBo9TTHIHZC8kq8fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1x4ztqbnQzOluXf0x28TvIgKGseSQkgVNylEY2IAzKn9tSTN+K7qPm3sL6pyB7cm22yCEGYrcvx25M3n/tszqnJ5Qvh8gBxvcVDqtwannrXuX9LKnQI9hmkMWY3hRhkF4AHdKAkNY2gKD5aBq2/CyTjrSGrje0cDcrMAPQVR08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CIGqmhx5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CIGqmhx5"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso3791025e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 08 May 2025 02:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746695662; x=1747300462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jtD1t5SqwVfSCPyTjNxq3c+2H14P2VPj1wlw+YRYZjE=;
        b=CIGqmhx5vL5fqu1yATZFv0VZ58N3X9p2mnpm+RxoOfE2E/sKWC3SimKxPjDQSNOy78
         kuW4q1OZWYz/54l0ZkWvyPA+AkJOKR2LJCJu91rImNHryJm5U86bJXhHiaXo4rI/5Pfy
         qXhLWufic3L967jB3PV9NbQZDnEKJRdko6eIg6bF0pZuARSKDPk+AZ+6WgO5j8mwEfdS
         U3GE6T484/kem3qM6y5Rj7280Ph3DgU0fY/TIcXloJfIpfZ0JufH9aB4GboZqCJ0SpC9
         doSywFvyZVU4VDEpyG4C67moons+UdqbQ0WIETw/tsxY0tSq+shtyPhgUB6wQNc5zkSK
         0kTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746695662; x=1747300462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtD1t5SqwVfSCPyTjNxq3c+2H14P2VPj1wlw+YRYZjE=;
        b=idx6RpOjMqKjUmDspAGlxdGhJYE8zZV3wOUM0oqSutAr+xmpUkejft1uJgAoM5AlTN
         mJObmgDpOYzSCN6Sf8/mpzefhsMy9HdIFL7wZBeT33TqiPYN6Q23w1D8VyHIuH5qaQ+i
         3QlJphU5mOdrvpKS6CKUjEK6lF+c68whsbLgZc3cD1ZrnYTxDhuNQ+qP8zVKz11rukLh
         uwtIRE5uSbFmcMPdlsSdYXx295vgUZiTZTxeaUFLdd0PQZAxUaRTm4uSgMRRtndIQu7z
         FUhtV0VM+Byps5n8wq9Gz2JWAT4Fklizo56bACNLi5XKcbY+J5Ln20FwFb6ZWIIiP4KM
         yYaw==
X-Forwarded-Encrypted: i=1; AJvYcCXj5Y0nLCtRHCctwxoNl7Biz3nvi88W5fUZoIQIqFi7vjyMG0lwPj8K77AuMyUCVWWlxNmKa//aWDZ+BsOIjt40Bx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEoI/nUmSVhMDBL6nTZ0Otlb1fBmM2WFruGR40QFt+qZIJcfQN
	NXvET81S6LmZjTnwgUzsRJD+ck3lg1KnCD0CcI79K/aalXBrIw2kH8AgC/dA3g==
X-Gm-Gg: ASbGncuEKt8fa5ttmN2fTIcTgOxWUgEUvtmshjUNiyqyJiAEB7kjWg8rk5vRZA6UNsU
	fdRc9GHvsKdQuUWMY/bLrRbYKZupQ/K1xp/tWubvulC9GmDDHlNZu6VgLDfvkbI5zF1mnRTq1fk
	msQeNJMvNywrd6dpVUWmYQ5Mx7UutMitdFqx74PrLbpGbX2xSjvcwZDMwkv2oUl+Q0cBjaB22vO
	TGuxnUnIiSea568dqxmxjMLWx3qaqAryeTAujJDuOIRuIb6GtUimvj10iX1hCW2sFzBsuluuFXg
	ssAhgQXzASaooCvAUgS6rFjff9VaLdHxnD7UGCO+r6F4H8bC1bPeRBqtYH6+GUQESHq/+aRAv/m
	kN+5kHg==
X-Google-Smtp-Source: AGHT+IF9SUYOnKs3lJu1vUeKHxmfYUfp4eeX4TzwT3TxRpgJ2RHbyMATX+EQtKICG97KoSCFK8KYGg==
X-Received: by 2002:a05:600c:3e84:b0:43c:eeee:b70a with SMTP id 5b1f17b1804b1-441d44dd23dmr51647125e9.22.1746695662495;
        Thu, 08 May 2025 02:14:22 -0700 (PDT)
Received: from google.com (24.204.140.34.bc.googleusercontent.com. [34.140.204.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd333326sm29694785e9.16.2025.05.08.02.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 02:14:22 -0700 (PDT)
Date: Thu, 8 May 2025 10:14:18 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/24] tracing: Introduce trace remotes
Message-ID: <aBx16qth045MwQJV@google.com>
References: <20250506164820.515876-1-vdonnefort@google.com>
 <20250506164820.515876-3-vdonnefort@google.com>
 <20250507202444.43963c84@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507202444.43963c84@gandalf.local.home>

[...]
> > +		remote->cbs->unload_trace_buffer(remote->trace_buffer_desc, remote->priv);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void trace_remote_unload(struct trace_remote *remote)
> > +{
> > +	lockdep_assert_held(&remote->lock);
> > +
> > +	if (!trace_remote_loaded(remote) || trace_remote_busy(remote))
> > +		return;
> 
> Can this cause leaks? Should trace_remote_unload() return an error value to
> let the caller know it wasn't unloaded?

No risk of leak here. This acts a like a refcount to make sure the buffer is
unloaded only when no one is reading and tracing_on=0.


[...]
