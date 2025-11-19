Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B952139C9
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Nov 2025 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763537485; cv=none; b=soTqMm4bDNBnRuZGQgNNi0A4/fW31bnNhjA++E0PvUHT/kJlG5YZH2E6k8CyQWYTBBLo3va6xoIgOMrr65xstRLlEazKY8QfNFlwzSnPmTGhf6GNZchOdbnc9Lsxg8GRB+fW32vWf0Mgf2eAsqUjiSs1yWYiW1FLT6ZiOo4DMN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763537485; c=relaxed/simple;
	bh=MIIwdEfgxTBBJrtLkK9DHcPCyyFXDL4Yjb+eXljNAWo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O+v3oMnnryMApOgabIPnr8J4G1CnQOikfHsC4GBDjNcivph7vD2uARj+sPwVvQbK6J29EnKBBVWnOhPLEo7cMHtJAgFNNopCBQwxzRZJE9wXlE6KCEftaO1YB99COiFDHyIuxOkWvocgQy6zEu9HelJmtn/XJi+D3wqkhLWzyUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h1eLGONM; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h1eLGONM"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b2e9ac45aso4078357f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Nov 2025 23:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763537482; x=1764142282; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YRb1WQ0gqk3VesjUw9X2idRsKQUF4vLOpbuptNdXlks=;
        b=h1eLGONMrdQGV+1UkVEgRHz8+vQc9vMIfEhY/LaZkHxuzGP50t+k1hjxZHjVX0iRjm
         dBOi92trQmcQSlYUFmZad2fdG61y7jqfJVFRjhIZLiV3sXg7snesf3MGTiTYGDFfHHEO
         v9VBMTEmt33rSwstgPbjeHnM4c7rnZjzSRxSp1wem+p47LXrTsNye1gwFWz8/ytYLzUW
         JYyfCCGgZ+ZXIAVVKVfjJGAA48nxzs5ivVaIr4LOot9cQytmloDrj0wk40Z47v2Uwjq6
         u/aW0h25EV2ABrnY8yxRHituUPCmRUsSWkGoe9kYSizVoirA87OxIpCyXKzH5LQIBpOP
         89Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763537482; x=1764142282;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRb1WQ0gqk3VesjUw9X2idRsKQUF4vLOpbuptNdXlks=;
        b=KVlKCP4oKlYE7Y23Oasen+lsA0fSCltMSg2dcatJ6uCZcdgzEWiaZ33vN8qykVhPve
         TY94z7ybaHlAu4L3BsZiW1De0qDlz2+ifemZaeoO3us8VRrNNwhKh6cVErW57nNAHqcl
         FQnW+ib4Y1gAaEVME5+vALdMdzOvxSOeWr9P/W11VbaF+YAt9V3AFBnaTZaSAaLtMuNa
         irJ9Vkku3uuVmYKdlI15KFh6zhJ9L4zTJr8VH4sw8ZiSKMCMq8lIDBRMzF4Sbokv9ytQ
         Uxq0Z7/sujjZJaOxLjEywzZh0uNdAgeUScKx7LeTo8iA+m9+FIWWX1jgcEHPgJuP+eUo
         FjcA==
X-Gm-Message-State: AOJu0YwC1ruW8GCPnEamZjhAEY9/saaxqiWhQWxFNrioVAG6KA97k6kK
	fjDZipEafN2xZlW9M8mtm4eD9A5Y+XFoptfLw8PJWIydGKsozg0bBm40whSOVPT8HQM=
X-Gm-Gg: ASbGncurIQb3It4tcBORVHjfiG6gY0GlFe32QA7jG0DgCEUMcanJJoePZMYVdPMcl9v
	HYypP3dEN0Y/DkStFmzjLNvrRvxoxxNtPDGmLMjSiiY+qXXS4cgN+MRErQs2CK65W3PYwtuITwR
	XfEMZwusUn4yqpnuSxkPWCX9lHA5LbRaE0iVyqUDSiPD3YZH6ulwC+r+CxD25ZuhZ81uonH1yO3
	718IOYeBa8V+t60OhWkVpeES/UsqSypvUBDIougi1C0+9cK3QZ6L+daOhByywGe/7lRQKIete2a
	kaX6pYydKEGRFMIy3BOMK+UfDTyoeVenjBX6wn5MZ6wRnSMFga9cz6yEBHVzG7dn+jb8hyX1dkh
	vvt2ZzKSZ0AqZdZy1VxeDxoNyKPhOrd8A5GP02R3xjNhZLdB+0lN39qtuZYIlWYTawdNwfdoxqZ
	1GZxkv13IlGgOIhjjV
X-Google-Smtp-Source: AGHT+IEKvffO+RboFuODPFbn2QrrbHcQOwtFRiaWeooXOuryeN0jhZ5Eqr6/P304qOPm5fMH02u1jw==
X-Received: by 2002:a05:6000:2dca:b0:429:b1e4:1f79 with SMTP id ffacd0b85a97d-42b5959eb99mr19973831f8f.58.1763537480617;
        Tue, 18 Nov 2025 23:31:20 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42b53f19664sm37589944f8f.36.2025.11.18.23.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:31:20 -0800 (PST)
Date: Wed, 19 Nov 2025 10:31:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org
Subject: [bug report] tracing: Have function graph tracer option sleep-time
 be per instance
Message-ID: <aR1yRQxDmlfLZzoo@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Steven Rostedt,

Commit 5abb6ccb58f0 ("tracing: Have function graph tracer option
sleep-time be per instance") from Nov 14, 2025 (linux-next), leads to
the following Smatch static checker warning:

    kernel/trace/trace_functions_graph.c:1649 func_graph_set_flag()
    warn: unsigned 'fgraph_no_sleep_time' is never less than zero.

    kernel/trace/trace_functions_graph.c:1671 func_graph_set_flag()
    warn: unsigned 'fgraph_no_sleep_time' is never less than zero.

kernel/trace/trace_functions_graph.c
    1637 static int
    1638 func_graph_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
    1639 {
    1640 /*
    1641  * The function profiler gets updated even if function graph
    1642  * isn't the current tracer. Handle it separately.
    1643  */
    1644 #ifdef CONFIG_FUNCTION_PROFILER
    1645         if (bit == TRACE_GRAPH_SLEEP_TIME && (tr->flags & TRACE_ARRAY_FL_GLOBAL) &&
    1646             !!set == fprofile_no_sleep_time) {
    1647                 if (set) {
    1648                         fgraph_no_sleep_time--;
--> 1649                         if (WARN_ON_ONCE(fgraph_no_sleep_time < 0))
                                                  ^^^^^^^^^^^^^^^^^^^^^^^^
Impossible.  Unsigned.

    1650                                 fgraph_no_sleep_time = 0;
    1651                         fprofile_no_sleep_time = false;
    1652                 } else {
    1653                         fgraph_no_sleep_time++;
    1654                         fprofile_no_sleep_time = true;
    1655                 }
    1656         }
    1657 #endif
    1658 
    1659         /* Do nothing if the current tracer is not this tracer */
    1660         if (tr->current_trace != &graph_trace)
    1661                 return 0;
    1662 
    1663         /* Do nothing if already set. */
    1664         if (!!set == !!(tr->current_trace_flags->val & bit))
    1665                 return 0;
    1666 
    1667         switch (bit) {
    1668         case TRACE_GRAPH_SLEEP_TIME:
    1669                 if (set) {
    1670                         fgraph_no_sleep_time--;
    1671                         if (WARN_ON_ONCE(fgraph_no_sleep_time < 0))
                                                  ^^^^^^^^^^^^^^^^^^^^^^^^
Same.

    1672                                 fgraph_no_sleep_time = 0;
    1673                 } else {
    1674                         fgraph_no_sleep_time++;
    1675                 }
    1676                 break;
    1677 
    1678         case TRACE_GRAPH_PRINT_IRQS:
    1679                 if (set)
    1680                         ftrace_graph_skip_irqs--;
    1681                 else
    1682                         ftrace_graph_skip_irqs++;
    1683                 if (WARN_ON_ONCE(ftrace_graph_skip_irqs < 0))
    1684                         ftrace_graph_skip_irqs = 0;
    1685                 break;
    1686 
    1687         case TRACE_GRAPH_ARGS:
    1688                 return ftrace_graph_trace_args(tr, set);
    1689         }
    1690 
    1691         return 0;
    1692 }

regards,
dan carpenter
