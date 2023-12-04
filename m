Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fy1vCCwv"
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746D5F3
	for <linux-trace-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:28:36 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so13567a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701692915; x=1702297715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7C/S8lLR0a29fUZmsld88FJ/WJYuF5hr49VjGtEE4Y=;
        b=Fy1vCCwvHRZTbOajNt7Ns8PVjPTU5zhEdS3moWWgdfWw8OUy2RkPmrleh4nkZuPg5p
         KkC/pxqhLGLQIvqamQHhbUceRuaLLuYIRfGh6mpH+GnC5JmZfVi0tJaTbZt0OFbIevyu
         kNHHSablozevS84nHHHh+U+ZSk4FzdmaHWT6QTwoJ9JklUulvgYs+Si7Qx/daeZfHa/K
         5nQTL07K+++1NnTgVv6R6W/gRSBBb32sIi0jdfDT0v0joIae6/aRXCn/spGVA8+Kp0O7
         bkRi6lWvN9nWHXXUnWr5C/zn3jv6BlWLxAhHILXK2cLZfRk8d9lrvVCKWr4knxbEvCpb
         LH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701692915; x=1702297715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7C/S8lLR0a29fUZmsld88FJ/WJYuF5hr49VjGtEE4Y=;
        b=mLCf54YeOV4vUZGrhCy+HTlHWTJv9T1DRxEWaNCGB5NrklTjkqbSruAk5+ttyA02fk
         /MKer6CJaMLZU3ShRa69zhxzxgMAZM2RfE7eLQ5Np8gst9GIYpTHbKGYJKd/OGMIKDcb
         rA5yT02AhNQUpzUNRqJ+IDko9C+0TKC+ZN6Lvhy+dAsGCizTZ4gV7jwbKL+9lFJ8icXx
         R8ASkCfLpVt1RWVF21WSsqsX62qOXGnobr11GYfuCGts8BKLxW8b+uIow+hL42pCXgKf
         H4anQ+VK5tA73VkJOiULMX7zqsA0MWY1oO9YrfisA4u8DTHEGQFO8xb/4TnDereJV5FX
         NXSA==
X-Gm-Message-State: AOJu0Ywe77sG2HeJMeGS1JVGMVjaxYpa+D6Ke2O2o+YF0qYRenTB3dk4
	SXRqb17bLrJ8R7KcrhyTrXizX3LdCj3FWJ1SNsaGGg==
X-Google-Smtp-Source: AGHT+IFISfJCPS1icgBXHHbLxd2ru8u88z5BIQahLRVRRq/0+B35P94aGebYvx3Y5PjogX8GYj138Ozk8TfjEa7KVRo=
X-Received: by 2002:a05:6402:35d3:b0:54c:9996:7833 with SMTP id
 z19-20020a05640235d300b0054c99967833mr81479edc.7.1701692914618; Mon, 04 Dec
 2023 04:28:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204114322.9218-1-lulie@linux.alibaba.com>
In-Reply-To: <20231204114322.9218-1-lulie@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Dec 2023 13:28:21 +0100
Message-ID: <CANn89iKUHQHA2wHw9k1SiazJf7ag7i4Tz+FPutgu870teVw_Bg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: add tracepoints for data send/recv/acked
To: Philo Lu <lulie@linux.alibaba.com>
Cc: netdev@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, martin.lau@linux.dev, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com, 
	alibuda@linux.alibaba.com, guwen@linux.alibaba.com, hengqi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 12:43=E2=80=AFPM Philo Lu <lulie@linux.alibaba.com> =
wrote:
>
> Add 3 tracepoints, namely tcp_data_send/tcp_data_recv/tcp_data_acked,
> which will be called every time a tcp data packet is sent, received, and
> acked.
> tcp_data_send: called after a data packet is sent.
> tcp_data_recv: called after a data packet is receviced.
> tcp_data_acked: called after a valid ack packet is processed (some sent
> data are ackknowledged).
>
> We use these callbacks for fine-grained tcp monitoring, which collects
> and analyses every tcp request/response event information. The whole
> system has been described in SIGMOD'18 (see
> https://dl.acm.org/doi/pdf/10.1145/3183713.3190659 for details). To
> achieve this with bpf, we require hooks for data events that call bpf
> prog (1) when any data packet is sent/received/acked, and (2) after
> critical tcp state variables have been updated (e.g., snd_una, snd_nxt,
> rcv_nxt). However, existing bpf hooks cannot meet our requirements.
> Besides, these tracepoints help to debug tcp when data send/recv/acked.

This I do not understand.

>
> Though kretprobe/fexit can also be used to collect these information,
> they will not work if the kernel functions get inlined. Considering the
> stability, we prefer tracepoint as the solution.

I dunno, this seems quite weak to me. I see many patches coming to add
tracing in the stack, but no patches fixing any issues.

It really looks like : We do not know how TCP stack works, we do not
know if there is any issue,
let us add trace points to help us to make forward progress in our analysis=
.

These tracepoints will not tell how many segments/bytes were
sent/acked/received, I really do not see
how we will avoid adding in the future more stuff, forcing the
compiler to save more state
just in case the tracepoint needs the info.

The argument of "add minimal info", so that we can silently add more
stuff in the future "for free" is not something I buy.

I very much prefer that you make sure the stuff you need is not
inlined, so that standard kprobe/kretprobe facility can be used.
