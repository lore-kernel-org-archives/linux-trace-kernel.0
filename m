Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A817C085
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712653337; cv=none; b=frpCcJ8CPx/XGihxm4V8IzgORm4fbTc6k9j/wDZkHMZKMaz8qS//ZuhzYWk6ERXqNlcbLbCzKklMAhWp2GH+POfF0LpO69DVc0pdKWPClmFFybP7jlo2wo1thHaigF7wIGu1Itk+cN92VaokEsx0B0dOSVJm7haNZlus0bOHKEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712653337; c=relaxed/simple;
	bh=euhpq35wFK9rmemS5feCCQzrNuJRo+rAgFPHnTkC0AQ=;
	h=From:To:Cc:Subject:In-Reply-To:MIME-Version:References:Date:
	 Message-ID:Content-Type; b=mXfBUgQU3+F/gZVcRqQbBL0Du4MR56xG4ga0zMNcc8nIED9RiQ0OKxszxXgnEd5+d5qZ6OLENB94kK2evyztIPIVCBz1TWMMUDaImeus3hUyPkYp40Op2zt3VDRBywUzgAJ/yWw8kmBIxbfHdYjx1kFTSyiD6/aLXHXqVsgo2jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KpQFxEST; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpQFxEST"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712653335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=euhpq35wFK9rmemS5feCCQzrNuJRo+rAgFPHnTkC0AQ=;
	b=KpQFxEST1MCnVLCSyly/XAxCsNUpnTs2CPXMKqFo4q83hy1A0QgReJY/wklwqGYqFDeuyE
	MTEKNSii8HspAk6j3HdSc1M4c69DgXbbajeFMpTa4X2/iPR8EZ8C6gCpyaYmLELklgOg+Y
	rdw4WryVTm5KOVY4B3+vge7HWWS7oUA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-LXvmf6K6N1ulvWa_Omqm2g-1; Tue, 09 Apr 2024 05:02:14 -0400
X-MC-Unique: LXvmf6K6N1ulvWa_Omqm2g-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78d73d93ea9so24698985a.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Apr 2024 02:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712653333; x=1713258133;
        h=message-id:date:references:mime-version:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=euhpq35wFK9rmemS5feCCQzrNuJRo+rAgFPHnTkC0AQ=;
        b=QgKbiGmhGwjgqnkc5bvVY7f8vjuQfpqIVw4CABhbS0UC00i1CcNrKQ4LfCM+JZy8V8
         2jr357K8SDEHgEKh5oxZdjYCU9G6SiZuEPWlLKFdB1u6UbIH2BpidVR/1GbV1EMo7jQP
         XFru6R0yBXoskCjlybQZgqiO4WYmSZC7gG+Fo7M7CtODwHJPXLtG3vSkYhIBAUOb3qpr
         TMPAKGGrrenj12hSdPGfvA1OSk17SQNqtjmulJ39u3VNy4mGFAicJakNCse7j/WYiQkx
         +eT9JRaOo91TtQhCMI8ZccdLI+8cI/bO+sR/9rHkFvTDvFjSlCgoCBhCg+MnAQnc+eHG
         sgaA==
X-Forwarded-Encrypted: i=1; AJvYcCUBjEXDgqPX4Cg83ZCN9sdhOY5OSmM65HFqyilcQJVwWD+XohMEGKxUxKmo3jjwaQLYRKzG5x1AlShYAg3oPe6EPIozTRon3IuBCP7/pcf7Ax8W
X-Gm-Message-State: AOJu0Yy+uW7umhF8KPv8JuLjyjamYaPTuyU4i9uXbNjy2eQtAUGZBu2U
	rmKkZchnuyXKD0btRjz9q2NsePXySQF3vw3gcgNmxgHmsfaMaZH9CxR9uFf8EWsjJKcmrEZOowI
	2AXjepz7Sr93JuLVeCCLp1+WuHWNvOm246S5FDnsxY8JK8G3YRBCrLL5FXI9tr/MlvjeHpQ==
X-Received: by 2002:a05:620a:198e:b0:78b:b0c2:17b6 with SMTP id bm14-20020a05620a198e00b0078bb0c217b6mr3047964qkb.11.1712653333501;
        Tue, 09 Apr 2024 02:02:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfJ9YI9fXu3bzCu+1ZKDrEFWqdCINgH4B4WK2Fj7Lg7ZxEGYh8Q7hvW22usdjnP1/pni2urA==
X-Received: by 2002:a05:620a:198e:b0:78b:b0c2:17b6 with SMTP id bm14-20020a05620a198e00b0078bb0c217b6mr3047929qkb.11.1712653333008;
        Tue, 09 Apr 2024 02:02:13 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id h6-20020ac85486000000b004347d76f43csm2678126qtq.79.2024.04.09.02.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 02:02:12 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, josh@joshtriplett.org, Kees Cook
 <keescook@chromium.org>, Eric Biederman <ebiederm@xmission.com>, Iurii
 Zaikin <yzaikin@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Petr
 Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Balbir Singh <bsingharora@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Joel Granados <j.granados@samsung.com>
Subject: Re: [PATCH v3 06/10] scheduler: Remove the now superfluous sentinel
 elements from ctl_table array
In-Reply-To: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-6-285d273912fe@samsung.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-0-285d273912fe@samsung.com>
 <20240328-jag-sysctl_remove_empty_elem_kernel-v3-6-285d273912fe@samsung.com>
Date: Tue, 09 Apr 2024 11:02:04 +0200
Message-ID: <xhsmhil0qaoz7.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

On 28/03/24 16:44, Joel Granados via B4 Relay wrote:
> From: Joel Granados <j.granados@samsung.com>
>
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which
> will reduce the overall build time size of the kernel and run time
> memory bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
>
> rm sentinel element from ctl_table arrays
>
> Acked-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>

Tested-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> Signed-off-by: Joel Granados <j.granados@samsung.com>

