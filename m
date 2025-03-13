Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B4F2620C1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855820; cv=none; b=cRM5XyWdo3st8qqWUSYzIsD1ObAyjuYziRj9EpFLIT1Sye5AD/eA7vFU1NjdncFCRZhszfsSYkjJnpK6JNeQ2iczCilbD4HuwFXwuMCcytQg9+VhBESihES6Rhb37HS5B3Vq3prQQMfeYKY34XX0Bl34D/KlLptjfLHV/Ysidog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855820; c=relaxed/simple;
	bh=79GHDmBWysM/3jVf+zt1nRrMiKGwdFe0zoLTIR2YYtA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bdRuImg6i1Fcx1ynaV1CQT1iy5RV8TZ9Izgg6g8v8PCy9JRVprfz8HPBhDbA+dqpw9EydY7yZIW22TzzeyBbD2lekKP/jXAyAXC1J7F8Jk0IBq7jPTxaVJ97g7+ijNNOYZLU6gFG/1BI/lJjpq94xQSLvAHcM9xW2eyChUe4CM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=id7DepZO; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="id7DepZO"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so525297f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741855816; x=1742460616; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wmkjdIv7fv9Uqg4OxsprnahPlrw/JaEwOjqhTm503qk=;
        b=id7DepZO8bwCQ+S4+dEUovtHJHKutrQaMOy5Kwre0FCEtGK3jpn+GhwPvar5pPBrAO
         /jdujwf2SIWureyeAKdQMEDI3IfLDagUT7JzNFVbydzGzZn6TQFzruLG+4qAFUXFoOa9
         InAn75QxJJvDL2Tv1G/MP8HiR/EwmeM+zkI21IWlXN71PflMDAlRdk0yuhSVibP7W4Hy
         /G9B6lJsP+GWEJmOgFLKczALDLB1UxLBiEKDyPsysQXBD3yhOg2V9/lVId64ryqnFS3/
         OyNA3Xw1n/StgjezojA3UM3WbdL5QMfsTCOBQ1xNipuKnW8uQRspAgdu2ffFxWVc83Ij
         k7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741855816; x=1742460616;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmkjdIv7fv9Uqg4OxsprnahPlrw/JaEwOjqhTm503qk=;
        b=qXBhbc1pVRpawYSlsEJX7JwggFFnCNboclkRZz4GUjhrlE18fCasnbzZfTCbaw7z7W
         9piOG4oNjS0KteJOXfl9XcUygXhPPW3npU17K0Ni/zrx1DWkZXwy/e7MkYESwoecGR4j
         TKKl8KTnEHA082mU/gCWLQaGCpqk2ijG4k6RST2xf2VtPYw7hpe4F6+SshOT8kNspNDt
         0XRcT7FjF5jdPkF+anTntUV0FXdKqww95LsyRTZ9/gzcPBx6oOr7lnR/6aWx6fLzN5JI
         XKPyDiD/jOXxBQkdofzWHrnXUhF8tQF2MhKawVvxy8FTnVe0InRWqE5wX++eMxjadWHY
         Crxg==
X-Gm-Message-State: AOJu0YzAO5fcGi4RgGnkyq3HpoQhwCALSt/TNYyHMjb1cv6sUBGUD/ac
	3xZUp5SYolaUzZ4NNwJMNfJ16VvR30VcBT1OsG62TzDIT+GfBQbhpUTs14RcFKA=
X-Gm-Gg: ASbGncuPWRX2Lp0NvRPwS7/BSrNwJH/EmG/I++HrdCnAcQ5hMdBQS3ztmcISqgwZbWI
	icmMYgyNBRAxBgUhtJPi3evueGblg+pg6DDmu13MrUHJ6kbm88Av9UUDnYjfps0zcZT68jK/I6P
	1rA60pLhGeiFcpIJ6aC9HnYsCSg9zOxgtg9nuRn0Eji4YK2PfXk8M2Qr4VEbh8vuxZ6jzYL8uWu
	ge7vRgml8TYX79LX/tW4TQ+XZF6N6hxhaULOpYW8Kgmgya/8lsi1D1vWJqcmAR1IZWBUxYgOPFZ
	fNvw2fyPJ3AATWtCesKOkooBp74vXuQUdjdgaxA8ydBTtQp9Zw==
X-Google-Smtp-Source: AGHT+IHEQ0kPh8U2Ut8pvkSdI7mQEg7p1aceM0zbPZaSu8Tipe96jusCA4PEZATBihVbXbVtlBOpBA==
X-Received: by 2002:a05:6000:402a:b0:38f:2efb:b829 with SMTP id ffacd0b85a97d-39132db8f39mr20521140f8f.50.1741855816527;
        Thu, 13 Mar 2025 01:50:16 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395cb318af0sm1360326f8f.73.2025.03.13.01.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 01:50:16 -0700 (PDT)
Date: Thu, 13 Mar 2025 11:50:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org
Subject: [bug report] tracing: Have persistent trace instances save module
 addresses
Message-ID: <44c5deaa-b094-4852-90f9-52f3fb10e67a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Steven Rostedt,

Commit dca91c1c5468 ("tracing: Have persistent trace instances save
module addresses") from Mar 5, 2025 (linux-next), leads to the
following Smatch static checker warning:

	kernel/trace/trace.c:9422 allocate_trace_buffer()
	error: uninitialized symbol 'scratch_size'.

kernel/trace/trace.c
    9403 static int
    9404 allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size)
    9405 {
    9406         enum ring_buffer_flags rb_flags;
    9407         struct trace_scratch *tscratch;
    9408         unsigned int scratch_size;
    9409 
    9410         rb_flags = tr->trace_flags & TRACE_ITER_OVERWRITE ? RB_FL_OVERWRITE : 0;
    9411 
    9412         buf->tr = tr;
    9413 
    9414         if (tr->range_addr_start && tr->range_addr_size) {
    9415                 /* Add scratch buffer to handle 128 modules */
    9416                 buf->buffer = ring_buffer_alloc_range(size, rb_flags, 0,
    9417                                                       tr->range_addr_start,
    9418                                                       tr->range_addr_size,
    9419                                                       struct_size(tscratch, entries, 128));
    9420 
    9421                 tscratch = ring_buffer_meta_scratch(buf->buffer, &scratch_size);
--> 9422                 setup_trace_scratch(tr, tscratch, scratch_size);

If ring_buffer_alloc_range() fails then scratch_size is uninitialized.
This is "harmless".  According to the C standard, it's undefined but in
the kernel we would allow it if setup_trace_scratch() is inlined.  Which
it probably will be.  The other thing is that if it's not inline the
UBSan detector will complain about these.

The compiler basically always initializes stack variables to zero these
days so adding an "= 0;" doesn't change runtime at all.

    9423 
    9424                 /*
    9425                  * This is basically the same as a mapped buffer,
    9426                  * with the same restrictions.
    9427                  */
    9428                 tr->mapped++;
    9429         } else {
    9430                 buf->buffer = ring_buffer_alloc(size, rb_flags);
    9431         }
    9432         if (!buf->buffer)
    9433                 return -ENOMEM;
    9434 
    9435         buf->data = alloc_percpu(struct trace_array_cpu);
    9436         if (!buf->data) {
    9437                 ring_buffer_free(buf->buffer);
    9438                 buf->buffer = NULL;
    9439                 return -ENOMEM;
    9440         }
    9441 
    9442         /* Allocate the first page for all buffers */
    9443         set_buffer_entries(&tr->array_buffer,
    9444                            ring_buffer_size(tr->array_buffer.buffer, 0));
    9445 
    9446         return 0;
    9447 }

regards,
dan carpenter
