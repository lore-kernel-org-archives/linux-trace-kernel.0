Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0823F2D879E
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Feb 2026 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771065398; cv=pass; b=ATUWKN2gxCH0ayVDGnhV6s5mmxQ9dxQX+Qr8MheoYsdn4eMAhWJFXrD3im5BG0VgDcw+P7YOIzfQM5ePMAxRz/yI6FUX8vLOHPYT4aO1MIgdThSFmqdfQld9vIxQCtJm9ocrhgs2iZDnxtabLk1zzm+qmMYyoJAsgFmoiZUwKHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771065398; c=relaxed/simple;
	bh=FXWt2KlXw9K3juFQMdPCT90DnaKOObpRwNUaZCuLXjI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qP2sCelpz+KZw3AttpcdurGdpqSnJ5nnkYzV3uD9rrMK59TlkPN45YB52fPy/o4eA/hC2pNBSiJYcKNBHdzhYx23kYCnWU9AjbK+5wHW2iSkK0NZVTL9qavAa8l37RT0kBgDaNchPQzuklasjtEq7vzeKr97WLFl8ZBxi11iO0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoHbFmvg; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoHbFmvg"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8f86167d39so213926966b.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Feb 2026 02:36:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771065395; cv=none;
        d=google.com; s=arc-20240605;
        b=UbMXgGnYi12+NJJTLe7NZWj4V+FWpQRg93hBd718BK82cDF4DvRsAKmp9NBclE9PKD
         4lQhRo3ezGNiPV6/iWmOxKDfovHV58wxLdO82Jd3ROqruVlcT2UODrMXLLwq3hPdDO1o
         +0I09RuM+B9/kyrvbF20OaulvmQJdsbEZheS1HL4oWhdKI06REIkUs9LigZtBeGr/7gk
         3pErL10oro6jwUI9rexNJKmhFZ/mSV8xthB/HQhjVi7kE/UaXS9ETJh8JrPdiUbJGl3u
         bfkH1yvo9qgIKf5l+Fsbgt+OILzvuIJV+WC0Aky5TyvZZcTYNQSfYQMI0Z4ZHXPA6YUI
         mdZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=1Z4WHQEPm2glVNHw11Am4OtEmlynF8EuuHMLw+oWeig=;
        fh=SFXLy/7slB7FgjAKTKbiPnrwv4J+btEVNHTUE9tyX6s=;
        b=ARYE2t7FJ8OdZRv61Jkn+V0R/jxrtwSxicFHxCtchuKS5VU9FZ16mj5qN5g4Hdw8U2
         hsLkbc5tJrGh6RkasoFFhio9aSs6USoJnqdwaXnfQoGAAqoYxWwSe0jWU4oZCdkf/9Uj
         U3LzxfVwz/E32lXGGolWSk28BiCwN6d9hKH3kHGJwO49rkU8LT3F6/6AYll/dY/8pZb1
         bvlg7/Tttq2BNOAH74xZB0oNEno3Vv2zjv5EIdVlc0UNWEU7QnVxtgVvBQDxlM0mP6dk
         vXWKXpiayh2xylB2hw1ySDP3KvNlssEGtEQ6bRM+h24wYuT+K452jIOAw4nB/iiFwhBh
         0ltg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771065395; x=1771670195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Z4WHQEPm2glVNHw11Am4OtEmlynF8EuuHMLw+oWeig=;
        b=BoHbFmvg/8ZP4k2cHbYYQu2xcSeUq2/sEz0ZZFQrwayT7Piz+cwpclhF6ffbv/IloN
         vQ/UOyBAgNMNtjw5Bor/TrDUoqsQtQABYN5VLax54kQFnVABgkvCwYH73FH9WerMEeTY
         Nluo0SyiCD5XngIi14bzrMb+tIJCySNHiYUN437FekeKBHKIaGIdZqcE5iCWcprm7F5Y
         B6dWqOyDJpzAs98160hzbiULpBsXXUM4Q8IIjGLoW89iPZwCfSx/1qg2yNbZnuohU1wv
         5vBvr/uvZ1cdPDy/mNp2rgIdicd13ktP8C3G1Zxc7bPYKRHriVm542lINMQBFC333kmL
         YvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771065395; x=1771670195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Z4WHQEPm2glVNHw11Am4OtEmlynF8EuuHMLw+oWeig=;
        b=u7D5y9lXJo2flLF0u4l11WXLopYsHr/pj+hqmVVolL/RqkyxaCRz9lcLAVBnMz/gus
         ChZW7GTpk3eSD3U1v4ewmy9S+chGMGq2/qLu7qrPNS65mUO/OoIk11P1030XKyiYNbv2
         U3DplRnB1bG7VRmrb64MKZj8KjfntG/Ve549f1gSGiT+sUeU9KWTaqBtGj90TJv0xX5t
         y53GxADObR3d3sgekv22cWFIxs3AOuNJNb29Vmje8UHlSDSf02Xa0WvvGF2fPKGgxeZj
         yurQWZFU2kyuGXWqbKf7aHOMf5H6nXo4T6vTiXhLvPCVUk1YcDnf0KnY8hYhltGxRAxR
         +5Zw==
X-Gm-Message-State: AOJu0YyFBdzsWeKPGcsBU3u3HuL4eASvDJX/DFIO+clqi8Ro6eg1BtEM
	RICDHqAeDNqu+naEEMh3dtnVk36hA4EC5nBrcd0jUvyeCfIZWRTaBHkeDYFEjhWplU4yvSeiGfm
	thPcP6KvE7Y683n5zYTdq2pgwqQfty3nAyucaREc=
X-Gm-Gg: AZuq6aIkasiCV3+nPewEmkNLKQt4iOfEAK+rukRabYJEt4xGI2DPwVgaZpLqZ5tWMAL
	MVnEBA51sJqcVnHpW0VoW5ah2Kj1K7qH8i1xdyCYgO27d9VCzMLgDs28nYV8RhPq/ssV8tB1IG1
	EjuXKFAF+2thNR+T2VldIYpieah7hVzRlC3rQ1s0ghlgroyG6q9/5VAER7D5L32jai3tLRgQFzT
	vwxHKI4qtTkCMdxkXPy0UPb/c06nfybIYwMB9P2kyrjcWUsNNulU1RwHMJ9jpG4WqEmQhkw8rw5
	L2dZXK96
X-Received: by 2002:a17:906:4fc4:b0:b8e:8874:8386 with SMTP id
 a640c23a62f3a-b8fb4176496mr225541366b.10.1771065395125; Sat, 14 Feb 2026
 02:36:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Sat, 14 Feb 2026 18:36:24 +0800
X-Gm-Features: AZwV_QiPaFqJUfLi2vqWSeiP4M57Cnsoehss8VZIVYg17sd5GfmN7WpCu2mUPXA
Message-ID: <CAErzpmtMrHWQVAQx=jiq_sWo=+c_JOUoQmPafo-fq+Q3qi+BBw@mail.gmail.com>
Subject: Enhancing Conditional Filtering for Function Graph Tracer
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steve and Masami,

I recently had an idea while using the function graph tracer.
Currently, it supports basic
filtering via set_ftrace_pid(PID-based) and
set_graph_function(function name-based).
However, this filtering mechanism feels somewhat limited. Given that
we already have
features like funcgraph-args, I wonder if we could enhance filtering by all=
owing
conditional tracking based on function parameters =E2=80=94 similar to how
trace events support
filters/triggers.

To simplify implementation, I propose extending a new trigger type
(e.g., "funcgraph").
In ftrace_graph_ignore_func, we could look up the corresponding trace_fprob=
e and
trace_event_file based on trace->func, then decide whether to trace
the function using
a helper like the following:

static bool ftrace_graph_filter(struct trace_fprobe *tf, struct
ftrace_regs *fregs,
                               struct trace_event_file *trace_file)
{
    struct fentry_trace_entry_head *entry;
    struct trace_event_buffer fbuffer;
    struct event_trigger_data *data;
    int dsize;

    dsize =3D __get_data_size(&tf->tp, fregs, NULL);
    entry =3D trace_event_buffer_reserve(&fbuffer, trace_file,
                                       sizeof(*entry) + tf->tp.size + dsize=
);
    if (!entry)
        return false;

    entry =3D ring_buffer_event_data(fbuffer.event);
    store_trace_args(&entry[1], &tf->tp, fregs, NULL, sizeof(*entry), dsize=
);

    list_for_each_entry_rcu(data, &trace_file->triggers, list) {
        if (data->cmd_ops->trigger_type =3D=3D TRIGGER_TYPE_FUNCGRAPH) {
            struct event_filter *filter =3D rcu_dereference_sched(data->fil=
ter);
            if (filter && filter_match_preds(filter, entry))
                return true; // Allow tracing
        }
    }
    return false; // Skip tracing
}

Does this approach make sense? Any suggestions or concerns?

Thanks,
Donglin
