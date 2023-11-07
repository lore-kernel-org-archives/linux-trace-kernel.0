Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F3B34CE7
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Nov 2023 19:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yx/c11xV"
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEEF184
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Nov 2023 11:55:41 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc938f9612so36821505ad.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Nov 2023 11:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699386941; x=1699991741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HNeFqgo6zpROkihy0ShoA85fAr1c1+bU52BjgzWcK1o=;
        b=Yx/c11xV+iyISUNC4tjBoSSI8tDR682FVRusZqHd8SLKwKdyfBTM8w5vQkcXgknLJ5
         jAgQELvmzCuVCKasvH6kMnPtHvprVKl7yqS82mCfrB/C94OMNdAzRAu1PvRDjHy91cqI
         QScGcCYchxw00U+ge59I8ZKuiL3/85122I5rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699386941; x=1699991741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNeFqgo6zpROkihy0ShoA85fAr1c1+bU52BjgzWcK1o=;
        b=P5czAr/xO4xZj9mZDzkFGFxWyyr/sepskE0AmiuPufZgQWjCweGbwByk2+ZasUkcK7
         nqYzpfAwhjUmkERjE8Wexry8eubmzZ3BxqSpfXxiu+5rR8XnJ5cDOS0SZr8k90CtbNok
         t9v12XqFRzjm01WF61DTTWO9aAbiRTLTfbS+eN6DAfKaHiZ9yNMIqXfiLXWx1OF2/hYl
         8cwNU6lzjb3f2h0qKiOf+g4LvTl+mCtoUTXq971R49oiQUxfdjSLNnJrhOk1YV2jQ4cf
         EuL3ltpEs4HdMG6GF3PvkmNyp8E4YqzreNWQD9qgjd93/+fD8sUq11HkTHLLLK22AMts
         +Grw==
X-Gm-Message-State: AOJu0YwjnkbGYVobaonmi8uc/D7gmaF2kILwHrS8nO9VA7tEO6fh8v+g
	kGequ9FxsJSdJhMaSXmkMBU8oA==
X-Google-Smtp-Source: AGHT+IEZgybC45XGlQUGbU637Xhd/YQognaCWgtAXzdYdCdXOmVngLWoQt1kbfTCkOpNfx5sZXCftA==
X-Received: by 2002:a17:903:2282:b0:1cc:ee07:1654 with SMTP id b2-20020a170903228200b001ccee071654mr35008plh.14.1699386940686;
        Tue, 07 Nov 2023 11:55:40 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jw24-20020a170903279800b001cc3a8af18dsm209511plb.60.2023.11.07.11.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 11:55:39 -0800 (PST)
Date: Tue, 7 Nov 2023 11:55:38 -0800
From: Kees Cook <keescook@chromium.org>
To: j.granados@samsung.com
Cc: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
	josh@joshtriplett.org, Eric Biederman <ebiederm@xmission.com>,
	Iurii Zaikin <yzaikin@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Balbir Singh <bsingharora@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 05/10] seccomp: Remove the now superfluous sentinel
 elements from ctl_table array
Message-ID: <202311071155.EE9C0FBF@keescook>
References: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-0-e4ce1388dfa0@samsung.com>
 <20231107-jag-sysctl_remove_empty_elem_kernel-v1-5-e4ce1388dfa0@samsung.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-5-e4ce1388dfa0@samsung.com>

On Tue, Nov 07, 2023 at 02:45:05PM +0100, Joel Granados via B4 Relay wrote:
> From: Joel Granados <j.granados@samsung.com>
> 
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which
> will reduce the overall build time size of the kernel and run time
> memory bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> 
> Remove sentinel element from seccomp_sysctl_table.
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
