Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F733EFD1F
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Feb 2026 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770385260; cv=none; b=RlYAtym+G8zu/TDc9RycVEOTTCneGubI/mN/RQPGEZXv8DTsUQODGBc0/tHgOCMQNCx8fK1ruZ/UKaGIkHC3YUaO0C3wVwZ38nDPImh7dYOUHzL4YXdrvxq1hwF4IDLvZorezu93XE8GWnDw5xnzjPV5XMt7yLncUhd4tcW1Wkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770385260; c=relaxed/simple;
	bh=tkIpRwBDYDdb/zCUYVv+On6clDAzHQr412pc0WKufOU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mP8cTnIZLesLCFtm/TUhqQg7n00Afa0N1ywfUMQFgF8rEP4wLMgtbDueIHQt5Ov8VRsAFzv1YLHJPpYFSeSpz/R/zDNoAtr1M0P9LwMpFi2n8eCljSkvh2SK6onVNt4Pz1XHwJ2Ce/5OAgdPIddzXpMIGPLlICzt8EG2hQpqN5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gaBiaGYp; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gaBiaGYp"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4805ef35864so18799505e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Feb 2026 05:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770385258; x=1770990058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9jkkg9jFlFPGR2rYLRkmcbA2bDtDRDVG58fqHbGGve8=;
        b=gaBiaGYprOGVVKcSifZsBXZTVSHlzXDqSaZ5Tum7ZUhFHNNF03MRUQSXBYnIZotfDv
         U89zUzgaPiKpJ3Hqq9ZcykDbdH+CtBOM+BCXPcEuLfHs844Fi79esf7lIwkWBB+h32HV
         fBeDc6XJPHPAigyrkgOQctAGmmhIDrIGQS46aTPW7UrziR80iPmfONCP64CP93LFB7a3
         Lb5DXkTJOyjdoeDx7v74wGW1Z/R6RsV/O0Yx1vpd/Mf8Shp8juqq5DqzYheifpaK7W9Z
         zaP9qtUaPMYVr4pfUdSOD1eC3gjjWBhBmfIej5i2ZTfl8D4cBt5S9N6iR4Fiki5wtZxf
         fz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770385258; x=1770990058;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jkkg9jFlFPGR2rYLRkmcbA2bDtDRDVG58fqHbGGve8=;
        b=Hz61dqGsz7UzzdXwOOoCLBdUzEqCbJb3bsTWsT3wbFdTKwx7mu4aMJnOdPn4qeZVKS
         L3BdvtIKVNTrwlO97+knzYTiKPqA3ZwLsxp0Ak911c/8vNDqDedhGfnKNXR8Wimdau67
         LbFU3xqW3MA+dQ4W5Vsc1XU//rspXx/MuOMaaRj9cwur3YG6hw3CpOINxA3/IvLuTuC2
         l9l4advcP+pbXAxFGew1blGZ/u14GB9fKKu477zDhF8cnrbT8y/qICJFps+9zqHCf2GA
         uEZQoSjzmNsEZ6G/v7Xp+2XufJked+rsZn/4yxDuJojFWnMhXI1stvOekmkBtVaa90lS
         p8MA==
X-Forwarded-Encrypted: i=1; AJvYcCWGrNpL1mU3hYcF+RUtrXf/UJY0hmXRn5OUu7etD+dplDSp2as5I1ZWJ1Cz0pD8Kd7JEWtE8duV7Q/GHpt7mi9F/3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5SqadPEPGmD1VFjrllKsbjZ0Y8gNV5L9qA5QexWZbZJNBkTP5
	HPS8JNQyCAIrFWx+3ediU1+UfCSD7VLWEcux3Z1QjfMAsCGzkmRWdYY9e9TEq2WBCc5zAOAgeyx
	FIF0A
X-Gm-Gg: AZuq6aLKCYHy0OzSnTPEPMwOQD2Z3BWTEcxtS+jx6wqVDltOVFJZOlGbbfLi5nmNpNr
	0ULIdcWHYs1Yf0hoVXrCUGUviY8GUzv859bV0j8u/kIZcoCtJZgVcW1AK6FZCuttZf4YDapNXpc
	R3nrRWi6pr2up/nW45wXgxoA/W6efL85naQdLa/HsBsTepbKIeiuRzzAgZVrkh6tUnum18jXz0h
	WfxlfqZZe3SygM6FZU/cC9WrryWwctsVnbA3zSvOMrXkBolrTl7gWtONjRRsgOoYmiZK5M8mcvf
	UGx4KrFgFyMpSDlzmfNGEnPxd5wc1XYD6eoiHgQGUH648pTmMrTEWcIsdOD9pXJUHNPNf3Y0iX9
	e1IY1Huf0YEnUyyQYB1nXGB5OKpZurL/8pgV3ohxYkLm6knKV29JkmfeK1r+T31dVoBr3NSGG/F
	joTWH6n57vWcOItWrW
X-Received: by 2002:a05:600c:8b57:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-4832021d9b3mr42698745e9.30.1770385258133;
        Fri, 06 Feb 2026 05:40:58 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d2bab2sm232209295e9.3.2026.02.06.05.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:40:57 -0800 (PST)
Date: Fri, 6 Feb 2026 16:40:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [bug report] tracing: Properly process error handling in
 event_hist_trigger_parse()
Message-ID: <aYXvZgN5nrTr9onx@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>

[ Smatch checking is paused while we raise funding.  #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Hello Miaoqian Lin,

Commit 0550069cc25f ("tracing: Properly process error handling in
event_hist_trigger_parse()") from Dec 11, 2025 (linux-next), leads to
the following Smatch static checker warning:

	kernel/trace/trace_events_hist.c:6925 event_hist_trigger_parse()
	error: we previously assumed 'trigger_data' could be null (see line 6856)

kernel/trace/trace_events_hist.c
    6855         trigger_data = trigger_data_alloc(cmd_ops, cmd, param, hist_data);
    6856         if (!trigger_data) {
    6857                 ret = -ENOMEM;
    6858                 goto out_free;

trigger_data is NULL here.

    6859         }
    6860 
    6861         ret = event_trigger_set_filter(cmd_ops, file, filter, trigger_data);
    6862         if (ret < 0)
    6863                 goto out_free;
    6864 
    6865         if (remove) {
    6866                 if (!have_hist_trigger_match(trigger_data, file))
    6867                         goto out_free;
    6868 
    6869                 if (hist_trigger_check_refs(trigger_data, file)) {
    6870                         ret = -EBUSY;
    6871                         goto out_free;
    6872                 }
    6873 
    6874                 event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
    6875                 se_name = trace_event_name(file->event_call);
    6876                 se = find_synth_event(se_name);
    6877                 if (se)
    6878                         se->ref--;
    6879                 ret = 0;
    6880                 goto out_free;
    6881         }
    6882 
    6883         if (existing_hist_update_only(glob, trigger_data, file))
    6884                 goto out_free;
    6885 
    6886         if (!get_named_trigger_data(trigger_data)) {
    6887 
    6888                 ret = create_actions(hist_data);
    6889                 if (ret)
    6890                         goto out_free;
    6891 
    6892                 if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
    6893                         ret = save_hist_vars(hist_data);
    6894                         if (ret)
    6895                                 goto out_free;
    6896                 }
    6897 
    6898                 ret = tracing_map_init(hist_data->map);
    6899                 if (ret)
    6900                         goto out_free;
    6901         }
    6902 
    6903         ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
    6904         if (ret < 0)
    6905                 goto out_free;
    6906 
    6907         ret = hist_trigger_enable(trigger_data, file);
    6908         if (ret)
    6909                 goto out_unreg;
    6910 
    6911         se_name = trace_event_name(file->event_call);
    6912         se = find_synth_event(se_name);
    6913         if (se)
    6914                 se->ref++;
    6915  out:
    6916         if (ret == 0 && glob[0])
    6917                 hist_err_clear();
    6918 
    6919         return ret;
    6920  out_unreg:
    6921         event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
    6922  out_free:
    6923         remove_hist_vars(hist_data);
    6924 
--> 6925         trigger_data_free(trigger_data);

Originally this was kfree(trigger_data) so passing a NULL pointer was
fine, but now it will crash.

    6926 
    6927         destroy_hist_data(hist_data);
    6928         goto out;
    6929 }
    6930 
    6931 static struct event_command trigger_hist_cmd = {
    6932         .name                        = "hist",
    6933         .trigger_type                = ETT_EVENT_HIST,
    6934         .flags                        = EVENT_CMD_FL_NEEDS_REC,
    6935         .parse                        = event_hist_trigger_parse,

regards,
dan carpenter
