Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793583;
	b=MSUYujPWa2kqM9PKaBjoe9rUKzyLmgIne1ymTjeFOTyRqCZ5SMdvHZnyVHTLqhbPYPYV
	 QA5qfsTHVsdcxKlu6uifIUTgOn2POy4NlNnAgptb6XGjsOpStjroSWNZgLO+t2e1WHy2c
	 TgaA3OVQsF2q1R/auodTxBow659UAzcNenTd/p61detGuqvbIRifP7Na0XH5UuhHJpYrq
	 w0bMS0SmxU+S6MPBryXT+W2G8GnPEPyPaGqHBwCq7CTP6JlnGHECzxljPq22HGO1CfwOC
	 lDUwKUx3BA6eX5IYKeccD9pYpNhin6jRvjoJ4B+5V/DascE7W99iTN8lyGBoiGpcCAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793583;
	h=DMARC-Filter:DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=yTfdL/943svahk2oANv264yMmLXyFyxWvQBqxkGE6Fw=;
	b=5DIIYy0+sBSsujEkOqm0EHT6COjuUoPrJsVakJ3+dbVstsZCnV7NPkaAyDJ6Q507i2+v
	 U5TM/nXUawFgzXcBExkwjTCSZ37TL/fkcMVi64gwu/p8PbVmmzyOhNnCqxtY7OyLZT9XV
	 TilpePvCQfk6RUfqChC8N0g3eZXQLXrifEFALAiDmAshs5DAPyM+++nxkotc/DdYp1ep+
	 YJUeaQmIekaiTwzlTOMFFUl9aUY8DhpzA2fhj5lweejCKNALSobwmAWz+MXow1WdUfaV/
	 puX/EosU0zxcFYqtGizJs1sXbybTNTo94E23wSeNXtS1tzI7wt0ZAnHF9GB/uw4uarQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cU2XDqPE;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EE7606A324
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 15:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48EE7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cU2XDqPE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795793583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yTfdL/943svahk2oANv264yMmLXyFyxWvQBqxkGE6Fw=;
	b=cU2XDqPEAqxZk+OlErOeyYKOssRG8uKiPeRDGriRv20X924cFWWfgtFtFV+QkyHPcceJyZ
	P4cdHJa7I3hYjjOvg4tzX/MoK7gaIM2gqB7qEplhgyRmpi8Lm51BHL891ASAekUcWMSH7R
	nlYYTs5Yo8bVAgkehWrTdDRr4mKMfl8=
X-MC-Rep: binary re single
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-3twSre7BPRa5ST0rCadwuA-1; Fri,
 27 Nov 2026 15:32:58 +0000
X-MC-Unique: 3twSre7BPRa5ST0rCadwuA-1
X-Mimecast-MFC-AGG-ID: 3twSre7BPRa5ST0rCadwuA_1795793577
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49FC11955F17;
	Fri, 27 Nov 2026 15:32:57 +0000 (UTC)
Received: from tglozar-thinkpadt14gen5.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 611AD1955F76;
	Fri, 27 Nov 2026 15:32:54 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [RFC PATCH 00/10] rtla/timerlat: Add auto-analysis action and report spike timestamps
Date: Fri, 27 Nov 2026 16:31:56 +0100
Message-ID: <20261127153206.134322-1-tglozar@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iVPS7TjYaPE99eCmH8zneF7KLKkobfuhlCEyE0dsQXs_1795793577
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

=== Problem ===

rtla timerlat already supports reacting to multiple spikes in one run by
resuming tracing using --on-threshold continue,

    $ rtla timerlat -q --thread 1000 --duration 10s \
        --on-threshold shell,command="echo Tracing stopped on latency spike" \
        --on-threshold trace \
        --on-threshold shell,command="echo Trace output:; tail -n5 timerlat_trace.txt" \
        --on-threshold continue

will stop tracing after each latency spike over 1000us and print the tail of its
trace:

    Tracing stopped on latency spike
    Saving trace to timerlat_trace.txt
    Trace output:
            <idle>-0       [003] dn.h2.. 10507.972291: irq_noise: local_timer:236 start 10507.972288915 duration 2208 ns
            <idle>-0       [003] d...3.. 10507.972293: thread_noise: swapper/3:0 start 10507.972289122 duration 1464 ns
        timerlatu/3-23927   [003] .....11 10507.972293: timerlat_sample: timer_latency=2319269 seqnum=8683 context=1
        timerlatu/3-23927   [003] d..h312 10507.972297: irq_noise: irq_work:246 start 10507.972295820 duration 1014 ns
        timerlatu/3-23927   [003] .....11 10507.972297: #8683  context thread timer_latency   2319269 ns
    Tracing stopped on latency spike
    Saving trace to timerlat_trace.txt
    Trace output:
            <idle>-0       [000] dn.h2.. 10508.176124: irq_noise: local_timer:236 start 10508.176121606 duration 2369 ns
            <idle>-0       [000] d...3.. 10508.176126: thread_noise: swapper/0:0 start 10508.176121766 duration 1973 ns
        timerlatu/0-23924   [000] .....11 10508.176127: timerlat_sample: timer_latency=1138875 seqnum=8894 context=1
        timerlatu/0-23924   [000] d..h312 10508.176131: irq_noise: irq_work:246 start 10508.176129579 duration 872 ns
        timerlatu/0-23924   [000] .....11 10508.176131: #8894  context thread timer_latency   1138875 ns
                                        Timer Latency
    0 00:00:12   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)      |    Ret user Timer Latency (us)
    CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max |      cur       min       avg       max
    0 #7185      |        0         0         1      1358 |        3         2         4      1367 |        4         3         5      1000
    1 #7175      |        0         0         5      1361 |        3         2         8      1368 |        4         3         7       987
    2 #7178      |        0         0         1      1468 |        4         2         4      1474 |        5         3         4       433
    3 #7184      |        0         0         3      2315 |        2         2         7      2319 |        4         3         6       667
    ---------------|----------------------------------------|----------------------------------------|---------------------------------------
    ALL #28722  e0 |                  0         2      2315 |                  2         6      2319 |                  3         6      1000

However, one cannot use rtla timerlat's built-in auto-analysis to analyze
multiple spikes, because auto-analysis is not an action - instead, it is
done at the end of measurement and only if measurement stopped by the spike,
i.e. not resumed --on-threshold continue and stopped by the user or duration
timer.

=== Proposed solution ===

This patchset adds a new action, "aa", that allows auto-analysis to be used
right after a spike is detected.

This makes analyzing multiple spikes in a single run possible by allowing
the measurement to be resumed after the auto-analysis.

Example (output squished for better readability):

    # rtla timerlat top -q --thread 1200 --duration 10s --on-threshold aa --on-threshold continue
    [  0d 00:00:00.310] ## CPU 1 hit stop tracing, analyzing it ## (seqnum 703)
    IRQ handler delay:      1247.64 us (99.44 %)
    IRQ latency:            1248.12 us
    Timerlat IRQ duration:     2.55 us (0.20 %)
    Blocking thread:           1.26 us (0.10 %)
        kwin_wayland:5350      1.26 us
    IRQ interference           2.02 us (0.16 %)
        irq_work:246           2.02 us
    Softirq interference       0.62 us (0.05 %)
        SCHED:7                0.62 us
    -------------------------------------------
    Thread latency:         1254.68 us (100%)
    Max timerlat IRQ latency from idle: 167.32 us in cpu 2
    [  0d 00:00:00.360] ## CPU 1 hit stop tracing, analyzing it ## (seqnum 752)
    IRQ handler delay:      1259.94 us (99.40 %)
    IRQ latency:            1260.40 us
    Timerlat IRQ duration:     3.60 us (0.28 %)
    Blocking thread:           1.16 us (0.09 %)
        kwin_wayland:5350      1.16 us
    IRQ interference           1.68 us (0.13 %)
        irq_work:246           1.68 us
    Softirq interference       0.69 us (0.05 %)
        SCHED:7                0.60 us
        RCU:9                  0.09 us
    -------------------------------------------
    Thread latency:         1267.53 us (100 %)
    Max timerlat IRQ latency from idle: 11.55 us in cpu 12
                                            Timer Latency
    0 00:00:11    |  IRQ Timer Latency (us)  | Thread Timer Latency (us) | Ret user Timer Latency (us)
    CPU COUNT     |  cur   min   avg    max  |  cur   min   avg    max   |  cur   min   avg    max
    0 #9943       |    1     0     0   1085  |    4     1     2   1091   |    7     2     3   1092
    1 #9943       |    0     0     0   1260  |    2     1     2   1267   |    3     2     2    966
    2 #9945       |    0     0     0    167  |    1     1     1    169   |    2     2     2    170
    3 #9944       |    0     0     0     93  |    2     1     1     95   |    3     2     2     96
    4 #9946       |    1     0     0     35  |    3     2     2     40   |    5     3     3     43
    5 #9945       |    1     0     0     12  |    2     2     2     54   |    3     3     3     63
    6 #9944       |    1     0     0     15  |    3     2     2     21   |    3     3     3     32
    7 #9945       |    1     0     0    131  |    3     2     3    137   |    4     3     3    140
    8 #9945       |    1     0     0     15  |    2     2     2     60   |    3     3     3     62
    9 #9944       |    1     0     0     14  |    2     2     2     22   |    3     3     3     28
    10 #9945      |    1     0     0     12  |    2     2     2     23   |    3     3     3     31
    11 #9944      |    1     0     0     14  |    2     2     2     20   |    3     3     3     29
    12 #9945      |    1     0     1     11  |    5     4     5     32   |    6     5     7     41
    13 #9946      |    1     1     1     11  |    5     4     5     26   |    8     5     7     33
    --------------|--------------------------|---------------------------|----------------------------
    ALL #139224 e0|          0     0   1260  |          1     2   1267   |          2     3   1092

Timestamps are collected as offsets from the starting value of the tracefs
clock per-CPU and displayed along the auto-analysis output, together with
timerlat sequence numbers, to distinguish between individual spikes.

The feature also makes auto-analysis flexible in other ways, for example, it
can be made conditional on the success of the preceding action, or clearing
the terminal (via shell,command=clear) can be added before it.

When the aa action is not used, the default end-of-measurement analysis is
unchanged. When it is used, rtla skips the default analysis, as the action
already ran on the stopped trace.

=== Known functional limitations ===

- Specifying "--on-threshold aa" together with "--aa-only ..." option of
  rtla-timerlat-top skips the "Max latency was ..." message at the end, if no
  latency has been seen. This happens because the default end-of-measurement
  analysis is skipped, the message is a part of it in the current
  implementation.
- When aa action is triggered multiple times in a row to analyze the same spike,
  for example, when "--on-threshold aa" is passed twice, or when there is both
  "--on-threshold aa" and "--on-end aa", the first run consumes the trace data,
  so there is nothing left to analyze for the subsequent runs. (Likely minor.)
- The formatting of the auto-analysis timestamp is inconsistent with the top
  elapsed time format: the former prints days with "d" suffix, the later without
  it. A unified format should be chosen.

=== Known implementation limitations ===

- Commit "rtla: Support auto-analysis as an action" folds in multiple changes
  of both auto-analysis and actions necessary for the auto-analysis action
  itself (passing context through struct actions, resetting aa structures, ...).
  Ideally, it should be separated into multiple commits.
- struct actions takes a pointer to the whole struct osnoise_tool instead of
  only the required parts, creating surface for bugs, e.g. in initialization
  order.
- timerlat_aa_reset() resets each field manually, creating the risk that a newly
  added field is not reset there.

=== Further related feature ideas ===

- When "--on-threshold aa" is used, summarize all spikes at the end of tracing.
- Allow saving the auto-analysis output into a file, optionally with a suffix,
  so that latter results would not overwrite earlier ones.

The aforementioned limitations will, if everything goes well, be addressed in
a follow-up version of the patchset.

Suggestions for further improvements, changes to the output or interface, or
implementation comments are welcome.

Tomas Glozar (10):
  rtla: Support auto-analysis as an action
  rtla/tests: Add unit tests for aa action
  rtla/tests: Add runtime tests for aa action
  Documentation/rtla: Document aa action
  rtla/trace: Add helper to read "now ts" stats field
  rtla/trace: Add helper to gather "now ts" over a CPU set
  rtla/trace: Allow storing start clock value of tracefs instances
  rtla/timerlat: Save the trace clock at measurement start
  rtla/timerlat_aa: Print time offset and seqnum of the spike
  Documentation/rtla: Document auto-analysis timestamps

 Documentation/tools/rtla/common_options.txt   |  12 +
 .../tools/rtla/rtla-timerlat-top.rst          |   9 +-
 tools/tracing/rtla/src/actions.c              |  39 ++-
 tools/tracing/rtla/src/actions.h              |   8 +-
 tools/tracing/rtla/src/cli.c                  |   6 +
 tools/tracing/rtla/src/common.c               |  21 +-
 tools/tracing/rtla/src/common.h               |   7 +
 tools/tracing/rtla/src/timerlat.c             |  14 ++
 tools/tracing/rtla/src/timerlat_aa.c          | 109 ++++++++-
 tools/tracing/rtla/src/trace.c                | 226 ++++++++++++++++++
 tools/tracing/rtla/src/trace.h                |  10 +
 tools/tracing/rtla/tests/osnoise.t            |   4 +
 tools/tracing/rtla/tests/timerlat.t           |  13 +
 tools/tracing/rtla/tests/unit/actions.c       |  31 ++-
 14 files changed, 483 insertions(+), 26 deletions(-)

-- 
2.56.1

