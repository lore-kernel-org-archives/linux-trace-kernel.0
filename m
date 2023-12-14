Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jfo+1DlF"
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70F910A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 Dec 2023 21:36:57 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6d9f7af8918so4643752a34.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 13 Dec 2023 21:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702532217; x=1703137017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rW/CLTesU9Nn+LDbwmg1S+LrWy0eO5LzJlVzZDN0NTk=;
        b=jfo+1DlFqx8LsY6i/hotCzNlUYjU1w3ZXEtYZFQbSP0KXI4qUbKIo09XJC9c10Rbnn
         Xp+iJwynQIu/0QwwzampcgNBc8dMd9Atlmd0rMys28PeomYDn9A5QIVm6CXhw+hGGaF2
         fmfQJ9ILZa9yt+SwM0u2YRM1R3wt9FPsDH2jW0fd3sKaAPD1BYR+djeV4YYi2DegDjm+
         LKZwWWQqKZ1YEJZFOehxysgPGxHsMbIuV3MM7HuqZhDniw0Zuy/4Pyqb9BZ0P2VP0+pc
         tqGbya/ImWZpBQjcU1dbPOEj3Ugjk+3CHtu61HN1ButCzD9+ds0NqrehKojA4S8MKCR1
         gsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702532217; x=1703137017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rW/CLTesU9Nn+LDbwmg1S+LrWy0eO5LzJlVzZDN0NTk=;
        b=Kj4u2/0Cc/lXhZSash8TXzVJ5JO7MtE3+CDtdKlVdp9A4thzZoLLgUZj4u8+yyIn3b
         q+J0o/4kyM+OiW68V2cfuQS2RBQCgN4VMq9HB/TmAsoULc9/hkCE9PlmUIuPW9IPcygq
         v9k4b9LuKQGOmvMopVR7M7qPGC5fjkUZEXCz2BEQ1vRtHsjHaDrhXO4dIAf/URFehZcc
         T/f1F9DbwOoFrLckS+t8nMdzd0QJZLuNCdk6NU7IK9hu9ygmjQUWJOFuC1+ZI6pRLtKy
         85wsChAbemmwf3s6d9kpNJUtjwpu/C7cwIMe50G9XF6tqyTId8X31UOo78vJYkvLQqkU
         ROAw==
X-Gm-Message-State: AOJu0Yz/UiwCWFwKkfyUcpuJx8RDWjraxnNziExfs+EIZYxs+STgLJxN
	1+u+nlloHv3iBhbnvhQ/DnXeQQ==
X-Google-Smtp-Source: AGHT+IH+QeozbSYX0p0iXQ2G4XEln4ZOmYJ/iRjOrOBzxt3QGNJfpEqpr0j+HhoTkIB2PwvvSueIuQ==
X-Received: by 2002:a05:6358:7e8d:b0:170:6d55:e82e with SMTP id o13-20020a0563587e8d00b001706d55e82emr12607996rwn.2.1702532217124;
        Wed, 13 Dec 2023 21:36:57 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id pv18-20020a17090b3c9200b0028b0424a4bcsm723845pjb.54.2023.12.13.21.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 21:36:56 -0800 (PST)
Date: Thu, 14 Dec 2023 11:06:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, catalin.marinas@arm.com,
	will@kernel.org, sudeep.holla@arm.com, rafael@kernel.org,
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	lukasz.luba@arm.com, rui.zhang@intel.com, mhiramat@kernel.org,
	daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq pressure feedback for the
 scheduler
Message-ID: <20231214053653.hnyeormwu42un5sc@vireshk-i7>
References: <20231212142730.998913-1-vincent.guittot@linaro.org>
 <20231212142730.998913-2-vincent.guittot@linaro.org>
 <2e8807b68133f4b3a72227122a9d9a05f3fbf9d8.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e8807b68133f4b3a72227122a9d9a05f3fbf9d8.camel@linux.intel.com>
X-Spam-Level: *

On 13-12-23, 16:41, Tim Chen wrote:
> Seems like the pressure value computed from the first CPU applies to all CPU.
> Will this be valid for non-homogeneous CPUs that could have different
> max_freq and max_capacity?

The will be part of different cpufreq policies and so it will work
fine.

-- 
viresh
